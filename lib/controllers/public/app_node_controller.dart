/*
* @overview: 全局-节点信息
* @Author: rcc 
* @Date: 2024-06-20 22:05:36 
*/

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_v2ray_desktop/flutter_v2ray_desktop.dart';
import 'package:get/get.dart';
import 'package:rc_widget/rc_widget.dart';
import 'package:yunyou_desktop/utils/app_utils.dart';
import 'package:yunyou_desktop/widgets/public/app_dialog.dart';

import '/controllers/base/app_getx_controller.dart';
import '/controllers/public/app_user_controller.dart';
import '/models/node_model.dart';

class AppNodeController extends AppGetxController {
  static AppNodeController get to => Get.find<AppNodeController>();

  /// 是否连接
  final RxBool isConnect = false.obs;

  /// 是否规则代理
  final RxBool isProxyOnly = true.obs;

  // 日志记录
  final List<String> logs = [];

  var statuss;

  /// vpn实例
  late final flutterV2ray = FlutterV2rayDesktop(
    statusListner: (status) {
      statuss = status;
      debugPrint(status.toString());
      isConnect.value = status.state == ConnectionState.connected;
    },
    logListner: (String log) {
      logs.add(log);
    },
  );

  /// 节点列表
  RxList<SubscribeNode> nodes = RxList();

  /// Svip节点列表
  RxList<SubscribeNode> snodes = RxList();

  /// 当前节点
  final Rxn<SubscribeNode> currentNode = Rxn<SubscribeNode>();

  /// 当前节点名称
  String get nodeName => currentNode.value?.title ?? '自动匹配';

  /// 当前节点ID
  int get nodeID => currentNode.value?.id ?? 0;

  /// 拼接节点信息
  String get getSSUrl =>
      'ss://${currentNode.value?.algorithm}:${currentNode.value?.password}@${currentNode.value?.url}:${currentNode.value?.port}';

  @override
  void onInit() {
    super.onInit();
    _onInit();
    debugPrint('[AppNodeController] onInit');
  }

  Future<void> _onInit() async {
    if (Platform.isWindows) {
      await Process.run('setx', ['http_proxy', '']);
      await Process.run('setx', ['https_proxy', '']);

      await flutterV2ray.setSystemProxy('');
    }
  }

  /// 初始化节点
  Future<void> initNodes() async {
    if (AppUserController.to.isNotLogin) return;

    if (nodes.isEmpty) {
      await getSubscribeNodes();
    }

    if (snodes.isEmpty) {
      await getSvipNodes();
    }

    final localProxy = await RcStorage.getString('isProxyOnly', '1');
    final localNodeName = await RcStorage.getString('nodeName');

    isProxyOnly.value = localProxy == '1';
    currentNode.value = nodes.firstWhereOrNull((each) => each.title == localNodeName);
  }

  /// 获取订阅节点
  Future<void> getSubscribeNodes() async {
    const String url = '/api/shadowscoks/list';
    final Map<String, dynamic> data = {
      'orderByColumn': 'sort',
      'vipType': 1,
      'pageSize': 120,
      'isAsc': 'asc',
    };

    final result = await RcHttp.get<SubscribeNodeList>(
      url,
      params: data,
      cancelToken: cancelToken,
      errorJson: () => SubscribeNodeList.init(),
      fromJson: (json) => SubscribeNodeList.fromJson(json),
    );

    if (result.code == 200) {
      nodes = result.data;
      nodes.refresh();
      print('获取普通节点列表成功');
    }
  }

  Future<void> getSvipNodes() async {
    const String url = '/api/shadowscoks/list';
    final Map<String, dynamic> data = {
      'orderByColumn': 'sort',
      'vipType': 2,
      'pageSize': 120,
      'isAsc': 'asc',
    };

    final result = await RcHttp.get<SubscribeNodeList>(
      url,
      params: data,
      cancelToken: cancelToken,
      errorJson: () => SubscribeNodeList.init(),
      fromJson: (json) => SubscribeNodeList.fromJson(json),
    );

    if (result.code == 200) {
      snodes = result.data;
      snodes.refresh();
      print('获取SVIP节点列表成功');
    }
  }

  /// 获取节点配置
  Future<String> getNodesInfo(nodeID) async {
    const String url = '/api/shadowscoks/use';
    final Map<String, dynamic> data = {
      'state': 1,
      'nodeId': nodeID,
    };

    final result = await RcHttp.get<NodeInfo>(
      url,
      params: data,
      cancelToken: cancelToken,
      errorJson: () => NodeInfo.init(),
      fromJson: (json) => NodeInfo.fromJson(json),
    );

    if (result.code == 200) {
      print('获取节点详细信息成功');
      currentNode.value = result.data;
    }
    print('\\\\\\\\\\\\/${result.data?.url}');
    print("/////////////${currentNode.value?.port}");
    print(getSSUrl);
    return getSSUrl;
  }

  /// 开始连接
  Future<void> startConnect() async {
    final s = AppUserController.to;
    if (AppUtils.isMobile()) {
      if (!_judgeIsVip()) {
        return;
      }
    } else {
      if (!s.isVip) {
        RcToast('VIP已过期');
        return;
      }
    }
    print('++++++++++$nodeID');
    if (nodeID == 0) {
      final isMatch = await autoMatch();

      if (!isMatch) {
        RcToast('节点信息获取失败2');
        return;
      }

      print('------------$nodeID');
    }

    final nodeSS = await getNodesInfo(nodeID);
    SingOutbound? outbound;
    try {
      outbound = getVpnConfig(nodeSS);
    } catch (e) {
      print(e);
    }
    if (outbound == null) {
      RcToast('节点信息获取失败');
      return;
    }

    var json = V2raySingParser.quick(outbound);

    if (outbound.config.isEmpty) {
      RcToast('节点信息获取失败1');
      return;
    }

    if (isProxyOnly.value) {
      json.route['rules'].add(
        {"rule_set": "geoip-cn", "outbound": "direct"},
      );
    }
    isConnect.value = true;

    Map configMap = {
      'crypto': currentNode.value?.algorithm,
      'name': currentNode.value?.title,
      'password': currentNode.value?.password,
      'address': currentNode.value?.url,
      'port': currentNode.value?.port,
    };

    await flutterV2ray.startV2Ray(
      config: json.json(),
      configMap: configMap,
      connectionType: ConnectionType.systemProxy,
    );

    // try {

    // } catch (_) {
    //   RcToast('连接异常');
    // }
  }

  /// 停止连接
  Future<void> stopConnect() async {
    await flutterV2ray.stopV2Ray();
  }

  /// 获取订阅配置
  SingOutbound getVpnConfig(String url) {
    final config = SingOutbound.fromUri(url);
    return config;
  }

  /// 切换节点
  Future<void> switchNode(SubscribeNode node) async {
    final s = AppUserController.to;
    if (AppUtils.isMobile()) {
      if (!_judgeIsVip()) {
        return;
      }
      if (s.vipType >= node.vipType!) {
        if (currentNode.value?.title != node.title) {
          currentNode.value = node;
          RcStorage.setString('nodeName', node.title!);

          if (isConnect.value) {
            await stopConnect();
            startConnect();
          }
          // isConnect.value = true;
        }
      } else {
        RcToast('请先开通该类型VIP');
        return;
      }
    } else {
      if (!s.isVip) {
        RcToast('VIP已过期');
        return;
      }

      if (s.vipType >= node.vipType!) {
        if (currentNode.value?.title != node.title) {
          currentNode.value = node;
          RcStorage.setString('nodeName', node.title!);

          if (isConnect.value) {
            await stopConnect();
            startConnect();
          }
          // isConnect.value = true;
        }
      } else {
        RcToast('请先开通该类型VIP');
        return;
      }
    }
  }

  /// 切换代理模式
  Future<void> switchProxyMode(bool value) async {
    if (AppUtils.isMobile()) {
      if (!_judgeIsVip()) {
        return;
      }
      if (_judgeIsSvip() && isProxyOnly.isTrue) {
        return;
      }
    }

    isProxyOnly.value = !value;

    print('isProxyOnly: ${isProxyOnly.value}');
    RcStorage.setString('isProxyOnly', isProxyOnly.value ? '1' : '0');
  }

  /// 获取服务器延迟
  // Future<int> getServerDelay(String trojan) async {
  //   final vpnConfig = getVpnConfig(trojan);

  //   return flutterV2ray.getServerDelay(url: nodeSS);
  // }

  /// 自动匹配
  Future<bool> autoMatch() async {
    if (nodes.isNotEmpty) {
      currentNode.value = nodes.first;
      RcStorage.setString('nodeName', nodes.first.title!);

      return true;
    }

    return false;
  }

  /// 重置节点信息
  Future<void> resetNodes() async {
    if (isConnect.value) {
      await stopConnect();
    }

    nodes.value = [];
    currentNode.value = null;

    await RcStorage.remove('nodes');
  }

  bool _judgeIsVip() {
    final s = AppUserController.to;
    if (!s.isVip) {
      String content = '您的账户已经过期，请续费后继续体验畅快感受。';
      content += '\n如果您刚购买完请耐心等待，会员时长会在 1 分钟内到账。';
      Get.dialog(
        AppDialog(
          title: '温馨提示',
          content: content,
          negativeBtnText: '取消',
          positiveBtnText: '去购买',
          onPositiveTap: () {
            Get.toNamed('/combo');
          },
        ),
      );
    }
    return s.isVip;
  }

  bool _judgeIsSvip() {
    final s = AppUserController.to;
    if (s.vipType < 2) {
      String content = '青铜会员无法使用安全模式，请升级会员等级后尝试。';
      content += '\n如果您刚购买完请耐心等待，会员时长会在 1 分钟内到账。';
      Get.dialog(
        AppDialog(
          title: '温馨提示',
          content: content,
          negativeBtnText: '取消',
          positiveBtnText: '去升级',
          onPositiveTap: () {
            Get.toNamed('/combo');
          },
        ),
      );
    }
    return s.vipType < 2;
  }
}

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final String msg;
  final int code;
  final int total;
  final List<MessageEntity> rows;

  MessageModel({
    required this.msg,
    required this.code,
    required this.total,
    required this.rows,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      msg: json['msg'] ?? '',
      code: json['code'] ?? 0,
      total: json['total'] ?? 0,
      rows: (json['rows'] as List?)?.map((e) => MessageEntity.fromJson(e)).toList() ?? [],
    );
  }

  factory MessageModel.init() => MessageModel(msg: '', code: 0, total: 0, rows: []);
}

class MessageEntity {
  final int noticeId;
  final String noticeTitle;
  final String noticeContent;
  final String createTime;

  MessageEntity({
    required this.noticeId,
    required this.noticeTitle,
    required this.noticeContent,
    required this.createTime,
  });

  factory MessageEntity.init() => MessageEntity(
        noticeId: 0,
        noticeTitle: '文章标题',
        noticeContent: '文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内',
        createTime: '2025-04-15 17:22:56',
      );

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      noticeId: json['noticeId'] ?? 0,
      noticeTitle: json['noticeTitle'] ?? '',
      noticeContent: json['noticeContent'] ?? '',
      createTime: json['createTime'] ?? '',
    );
  }

  String get normalContent {
    Document document = parse(noticeContent);
    return document.body?.text ?? '';
  }

  String get formatMessageTime {
    DateTime timestamp = DateTime.parse(createTime);
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = DateTime(now.year, now.month, now.day - 1);
    if (timestamp.isAfter(todayStart)) {
      // 今天的消息
      return DateFormat('HH:mm').format(timestamp);
    } else if (timestamp.isAfter(yesterdayStart)) {
      // 昨天的消息
      return '昨天 ${DateFormat('HH:mm').format(timestamp)}';
    } else {
      // 更早的消息
      return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
    }
  }
}

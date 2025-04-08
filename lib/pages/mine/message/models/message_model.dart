import 'package:intl/intl.dart';

class MessageModel {
  final String msg;
  final int code;
  final List<MessageEntity> data;

  MessageModel({
    required this.msg,
    required this.code,
    required this.data,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      msg: json['msg'] ?? '',
      code: json['code'] ?? 0,
      data: (json['data'] as List?)?.map((e) => MessageEntity.fromJson(e)).toList() ?? [],
    );
  }

  factory MessageModel.init() => MessageModel(msg: '', code: 0, data: []);
}

class MessageEntity {
  final int id;
  final String title;
  final String content;
  final int time;

  MessageEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
  });

  factory MessageEntity.init() => MessageEntity(
        id: 0,
        title: '文章标题',
        content: '文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内',
        time: DateTime.now().millisecondsSinceEpoch,
      );

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      time: json['time'] ?? 0,
    );
  }

  String get formatMessageTime {
    DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(time);
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

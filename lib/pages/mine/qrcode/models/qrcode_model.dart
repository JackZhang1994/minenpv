import 'package:intl/intl.dart';

class QrcodeEntity {
  final int id;
  final String title;
  final String content;
  final int time;

  QrcodeEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
  });

  factory QrcodeEntity.fromJson(Map<String, dynamic> json) {
    return QrcodeEntity(
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

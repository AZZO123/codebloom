import 'package:intl/intl.dart';

class Reminder {
  String title;
  DateTime dateTime;

  Reminder({required this.title, required this.dateTime});

  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'date': DateFormat('yyyy-MM-dd').format(dateTime),
      'time': DateFormat('HH:mm a').format(dateTime),
    };
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}

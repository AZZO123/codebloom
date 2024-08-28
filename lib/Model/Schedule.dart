// ignore_for_file: prefer_collection_literals, unnecessary_this

class Schedule {
  int? id;
  int? plantId;
  String? day;
  String? task;
  String? note;
  String? time;

  Schedule({this.id, this.plantId, this.day, this.task, this.note, this.time});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    day = json['day'];
    task = json['task'];
    note = json['note'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['plant_id'] = this.plantId;
    data['day'] = this.day;
    data['task'] = this.task;
    data['note'] = this.note;
    data['time'] = this.time;
    return data;
  }
}

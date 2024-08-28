// ignore_for_file: prefer_collection_literals, unnecessary_this

import 'package:palnt_app/Model/Alert.dart';
import 'package:palnt_app/Model/Note.dart';
import 'package:palnt_app/Model/Photo.dart';
import 'package:palnt_app/Model/Schedule.dart';

class Plantapi {
  int? id;
  int? userId;
  String? plantName;
  String? plantType;
  String? careInstructions;
  List<Photo>? photo;
  List<Schedule>? schedule;
  List<Alert>? alert;
  List<Note>? note;

  Plantapi(
      {this.id,
      this.userId,
      this.plantName,
      this.plantType,
      this.careInstructions,
      this.photo,
      this.schedule,
      this.alert,
      this.note});

  Plantapi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    plantName = json['plant_name'];
    plantType = json['plant_type'];
    careInstructions = json['care_instructions'];
    if (json['photo'] != null) {
      photo = <Photo>[];
      json['photo'].forEach((v) {
        photo!.add(Photo.fromJson(v));
      });
    }
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
      });
    }
    if (json['alert'] != null) {
      alert = [];
      json['alert'].forEach((v) {
        alert!.add(Alert.fromJson(v));
      });
    }
    if (json['note'] != null) {
      note = [];
      json['note'].forEach((v) {
        note!.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plant_name'] = this.plantName;
    data['plant_type'] = this.plantType;
    data['care_instructions'] = this.careInstructions;
    if (this.photo != null) {
      data['photo'] = this.photo!.map((v) => v.toJson()).toList();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    if (this.alert != null) {
      data['alert'] = this.alert!.map((v) => v.toJson()).toList();
    }
    if (this.note != null) {
      data['note'] = this.note!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

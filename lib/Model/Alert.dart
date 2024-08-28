// ignore_for_file: prefer_collection_literals, unnecessary_this

class Alert {
  int? id;
  int? plantId;
  String? name;
  String? time;
  String? date;
  int? isActive;

  Alert({
    this.id,
    this.plantId,
    this.name,
    this.time,
    this.date,
    this.isActive,
  });

  Alert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    name = json['name'];
    time = json['time'];
    date = json['date'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['plant_id'] = this.plantId;
    data['name'] = this.name;
    data['time'] = this.time;
    data['date'] = this.date;
    data['is_active'] = this.isActive;

    return data;
  }
}

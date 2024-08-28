// ignore_for_file: prefer_collection_literals, unnecessary_this

class Photo {
  int? id;
  int? plantId;
  String? photoUrl;
  String? dateTaken;

  Photo({this.id, this.plantId, this.photoUrl, this.dateTaken});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    photoUrl = json['photo_url'];
    dateTaken = json['date_taken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['plant_id'] = this.plantId;
    data['photo_url'] = this.photoUrl;
    data['date_taken'] = this.dateTaken;
    return data;
  }
}

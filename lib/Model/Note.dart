// ignore_for_file: prefer_collection_literals, unnecessary_new

class Note {
  int? id;
  int? plantId;
  String? noteContent;
  String? dateAdded;

  Note({this.id, this.plantId, this.noteContent, this.dateAdded});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    noteContent = json['note_content'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['plant_id'] = plantId;
    data['note_content'] = noteContent;
    data['date_added'] = dateAdded;
    return data;
  }
}

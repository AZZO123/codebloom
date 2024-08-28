// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:palnt_app/Constant/Lists.dart';
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Model/Reminder.dart';
import 'package:palnt_app/Services/NetworkClient.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/Services/network_connection.dart';
import 'package:palnt_app/View/Home/HomePage.dart';
import '../../../Services/Failure.dart';

class AddPlantController with ChangeNotifier {
  final titleController = TextEditingController();
  final notecontroller = TextEditingController();
  DateTime? selectedDateTime;
  List<Reminder> listreminder = [];
  void editAlert(int index, String newName, String datetime) {
    DateTime newDateTime = DateFormat('yyyy-MM-dd HH:mm').parse('$datetime');
    listreminder[index] = Reminder(title: newName, dateTime: newDateTime);
    notifyListeners();
  }

  void deleteAlert(int index) {
    listreminder.removeAt(index);
    notifyListeners();
  }

  void editNote(int index, String newNote) {
    listnotes[index] = newNote;
    notifyListeners();
  }

  void deleteNote(int index) {
    listnotes.removeAt(index);
    notifyListeners();
  }

  void saveReminder(BuildContext context) {
    if (selectedDateTime != null) {
      final reminder = Reminder(
        title: titleController.text,
        dateTime: selectedDateTime!,
      );
      listreminder.add(reminder);

      Navigator.of(context).pop();
      titleController.clear();
      selectedDateTime = null;
      notifyListeners();
    } else {}
  }

  var plant_type;
  oninit(var planttype) {
    plant_type = planttype;

    for (int i = 0; i < days.length; i++) {
      List<TextEditingController> noteRowControllers = [];
      List<TextEditingController> timeRowControllers = [];
      for (int j = 0; j < tasks.length; j++) {
        noteRowControllers.add(TextEditingController());
        timeRowControllers.add(TextEditingController());
      }
      noteControllers.add(noteRowControllers);
      timeControllers.add(timeRowControllers);
    }
  }

  List<List<TextEditingController>> noteControllers = [];

  List<List<TextEditingController>> timeControllers = [];

  @override
  void dispose() {
    for (var controllers in noteControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    for (var controllers in timeControllers) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  List<XFile> images = [];
  static NetworkClient client = NetworkClient(http.Client());

  ImagePicker picker = ImagePicker();
  removeimageformlist(XFile image) {
    images.remove(image);
    notifyListeners();
  }

  List<String> listnotes = [];
  addnotes() {
    listnotes.add(notecontroller.text);
    notecontroller.clear();
    notifyListeners();
  }

  final plantinfo = TextEditingController();
  final plantname = TextEditingController();
  Future<void> AddPlant(BuildContext context) async {
    EasyLoading.show();
    try {
      final connected = await NetworkConnection.isConnected();
      if (connected) {
        List<http.MultipartFile> imageFiles = [];
        for (var image in images) {
          var multipartFile = await http.MultipartFile.fromPath(
            'photos[]',
            image.path,
          );
          imageFiles.add(multipartFile);
        }

        Map<String, String> notes = {};
        for (var i = 0; i < listnotes.length; i++) {
          notes["notes[$i]"] = listnotes[i];
        }

        List<Map<String, String>> alertsList = listreminder.map((reminder) {
          return {
            "name": reminder.title,
            "time": DateFormat('HH:mm').format(reminder.dateTime).toString(),
            "date":
                DateFormat('yyyy-MM-dd').format(reminder.dateTime).toString(),
          };
        }).toList();

        Map<String, dynamic> scheduleData = {};
        for (int i = 0; i < days.length; i++) {
          List<Map<String, String>> tasksData = [];
          for (int j = 0; j < tasks.length; j++) {
            tasksData.add({
              "task": tasks[j],
              "note": noteControllers[i][j].text,
              "time": timeControllers[i][j].text,
            });
          }
          scheduleData[days[i]] = tasksData;
        }

        String scheduleJson = jsonEncode(scheduleData);

        final requestBody = {
          "plant_name": plantname.text,
          "care_instructions": plantinfo.text,
          "schedule": scheduleJson,
          "plant_type": plant_type.toString(),
          "alerts": jsonEncode(alertsList),
          ...notes,
        };

        log(requestBody.toString());

        final request = await client.requestmultiimage(
          path: AppApi.store_plant,
          body: requestBody,
          images: imageFiles,
        );

        log(request.files.asMap().toString());

        var response = await request.send();

        response.stream.bytesToString().then((value) => log(value));

        if (response.statusCode == 200) {
          CustomRoute.RouteAndRemoveUntilTo(context, HomePage());

          EasyLoading.dismiss();
        } else if (response.statusCode == 404) {
          EasyLoading.dismiss();
          EasyLoading.showError(ResultFailure('').message);
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(ServerFailure().message);
        }
      }
    } catch (e) {
      log(e.toString());
      EasyLoading.dismiss();
      EasyLoading.showError(GlobalFailure().message);
    }
  }

  Future pickMultiimage(BuildContext context) async {
    try {
      images = await picker.pickMultiImage();

      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

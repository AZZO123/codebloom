// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:palnt_app/Constant/Lists.dart';
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Model/Plantfromapi.dart';
import 'package:palnt_app/Model/Reminder.dart';
import 'package:palnt_app/Model/Schedule.dart';
import 'package:palnt_app/Services/NetworkClient.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/Services/network_connection.dart';
import 'package:palnt_app/View/Home/HomePage.dart';
import '../../../Services/Failure.dart';

class EditPlantController with ChangeNotifier {
  final titleController = TextEditingController();
  final notecontroller = TextEditingController();
  DateTime? selectedDateTime;

  List<Reminder> listreminder = [];
  void editAlert(int index, String newName, String newTime, String newDate) {
    DateTime newDateTime =
        DateFormat('yyyy-MM-dd HH:mm').parse('$newDate $newTime');
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

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        notifyListeners();
      }
    }
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
  int? id_plant;
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

  Plantapi? plantold;
  loadPlantData(Plantapi plantData) {
    plantold = plantData;
    id_plant = plantData.id;
    log(plantData.schedule!.map((e) => e.day).toList().toString());
    plantname.text = plantData.plantName!;
    plantinfo.text = plantData.careInstructions!;
    plant_type = plantData.plantType;

    listnotes = List<String>.from(plantData.note!.map((e) => e.noteContent));

    listreminder = (plantData.alert ?? []).map<Reminder>((alert) {
      return Reminder(
        title: alert.name!,
        dateTime:
            DateFormat('yyyy-MM-dd HH:mm').parse('${alert.date} ${alert.time}'),
      );
    }).toList();

    final List<Schedule> scheduleList = plantData.schedule!;

    final Map<String, List<Map<String, String>>> scheduleMap = {};

    for (Schedule entry in scheduleList) {
      String day = entry.day!;
      String task = entry.task!;
      String note = entry.note ?? '';
      String time = entry.time ?? '';

      if (!scheduleMap.containsKey(day)) {
        scheduleMap[day] = [];
      }

      scheduleMap[day]!.add({'task': task, 'note': note, 'time': time});
    }

    for (int i = 0; i < days.length; i++) {
      String day = days[i];

      if (scheduleMap.containsKey(day)) {
        List<Map<String, String>> dayTasks = scheduleMap[day]!;

        for (int j = 0; j < tasks.length; j++) {
          String task = tasks[j];

          Map<String, String>? taskData = dayTasks.firstWhere(
              (taskEntry) => taskEntry['task'] == task,
              orElse: () => {'note': '', 'time': ''});

          noteControllers[i][j].text = taskData['note']!;
          timeControllers[i][j].text = taskData['time']!;
        }
      } else {
        for (int j = 0; j < tasks.length; j++) {
          noteControllers[i][j].text = '';
          timeControllers[i][j].text = '';
        }
      }
    }

    notifyListeners();
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

  removeimagefromapi(int id, BuildContext context) async {
    EasyLoading.show();
    try {
      final request = await client.request(
        requestType: RequestType.POST,
        path: AppApi.delete_photo(id),
      );

      if (request.statusCode == 200) {
        log(request.body);
        CustomRoute.RouteTo(context, HomePage());
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
    }

    notifyListeners();
  }

  deletepalnt(int id, BuildContext context) async {
    EasyLoading.show();
    try {
      final request = await client.request(
        requestType: RequestType.POST,
        path: AppApi.delete_plant(id),
      );

      if (request.statusCode == 200) {
        log(request.body);
        CustomRoute.RouteAndRemoveUntilTo(context, HomePage());
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
    }

    notifyListeners();
  }

  getplant() async {
    EasyLoading.show();
    try {
      final request = await client.request(
        requestType: RequestType.GET,
        path: AppApi.get_plant(id_plant!),
      );

      if (request.statusCode == 200) {
        log(request.body);

        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
    }

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
  Future<void> EditPlant(BuildContext context) async {
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
          path: AppApi.update_plant(id_plant!),
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

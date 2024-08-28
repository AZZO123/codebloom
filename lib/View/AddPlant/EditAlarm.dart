// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, must_be_immutable, use_key_in_widget_constructors, avoid_print, unnecessary_new

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palnt_app/Controller/Provier.dart';
import 'package:palnt_app/Model/Reminder.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/AddPlant/Controller/AddPlantController.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditAlaram extends StatefulWidget {
  EditAlaram({this.controller, this.reminder, this.index});
  AddPlantController? controller;
  Reminder? reminder;
  int? index;

  @override
  State<EditAlaram> createState() => _EditAlaramState();
}

class _EditAlaramState extends State<EditAlaram> {
  String? dateTime;
  bool repeat = false;

  DateTime? notificationtime;

  String? name = "none";
  int? Milliseconds;

  @override
  void initState() {
    context.read<alarmprovider>().GetData();
    widget.controller!.titleController.text = widget.reminder!.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.check),
          // )
        ],
        automaticallyImplyLeading: true,
        title: const Text(
          "تعديل المنبه",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: CupertinoDatePicker(
              showDayOfWeek: true,
              initialDateTime: widget.reminder!.dateTime,
              minimumDate: widget.reminder!.dateTime,
              dateOrder: DatePickerDateOrder.dmy,
              onDateTimeChanged: (va) {
                widget.controller!.listreminder[widget.index!].dateTime = va;
                widget.controller!.notifyListeners();
                dateTime = DateFormat().add_jms().format(va);

                Milliseconds = va.microsecondsSinceEpoch;

                notificationtime = va;

                print(dateTime);
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: widget.controller!.titleController,
                  onChanged: (value) {
                    widget.controller!.listreminder[widget.index!].title =
                        value;
                    widget.controller!.notifyListeners();
                  },
                  decoration: InputDecoration(
                    labelText: 'اسم التنبيه',
                  ),
                )),
          ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(" Repeat daily"),
          //     ),
          //     CupertinoSwitch(
          //       value: repeat,
          //       onChanged: (bool value) {
          //         repeat = value;

          //         if (repeat == false) {
          //           name = "none";
          //         } else {
          //           name = "Everyday";
          //         }

          //         setState(() {});
          //       },
          //     ),
          //   ],
          // ),
          ElevatedButton(
              onPressed: () {
                Random random = new Random();
                int randomNumber = random.nextInt(100);

                context.read<alarmprovider>().SetAlaram(
                    widget.controller!.titleController.text,
                    dateTime!,
                    true,
                    name!,
                    randomNumber,
                    Milliseconds!);
                context.read<alarmprovider>().SetData();

                context.read<alarmprovider>().SecduleNotification(
                    widget.controller!.titleController.text,
                    notificationtime!,
                    randomNumber);
                widget.controller!.editAlert(
                  widget.index!,
                  widget.reminder!.title,
                  widget.reminder!.dateTime.toString(),
                );
                CustomRoute.RoutePop(context);
              },
              child: Text("تعديل المنبه")),
        ],
      ),
    );
  }
}

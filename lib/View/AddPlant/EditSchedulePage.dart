// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:palnt_app/Constant/Lists.dart';
import 'package:palnt_app/View/AddPlant/Controller/EditPlantController.dart';

class EditSchedulePage extends StatefulWidget {
  EditSchedulePage({required this.controller});
  EditPlantController controller;

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("جدول النبتة"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            dataRowMaxHeight: 150,
            dataRowMinHeight: 10,
            columns: [
              DataColumn(label: Text("اليوم")),
              DataColumn(label: Text("الري")),
              DataColumn(label: Text("التسميد")),
              DataColumn(label: Text("التغذية")),
              DataColumn(label: Text("التعريض لضوء الشمس")),
              DataColumn(label: Text("الري بماء المطر")),
            ],
            rows: [
              for (int i = 0; i < days.length; i++)
                DataRow(
                  cells: [
                    DataCell(Text(days[i])),
                    for (int j = 0; j < tasks.length; j++)
                      DataCell(
                        Column(
                          children: [
                            Expanded(
                              child: TextField(
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                controller: widget.controller.noteControllers[i]
                                    [j],
                                decoration: InputDecoration(
                                  hintText: "الملاحظة",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onTapOutside: (event) => FocusManager
                                          .instance.primaryFocus
                                          ?.unfocus(),
                                      controller: widget
                                          .controller.timeControllers[i][j],
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "الوقت (ساعة:دقيقة)",
                                      ),
                                      keyboardType: TextInputType.datetime,
                                    ),
                                  ),
                                  Gap(20),
                                  GestureDetector(
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        initialEntryMode:
                                            TimePickerEntryMode.dialOnly,
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        setState(() {
                                          final now = DateTime.now();
                                          final formattedTime = DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              pickedTime.hour,
                                              pickedTime.minute);
                                          widget.controller
                                                  .timeControllers[i][j].text =
                                              "${formattedTime.hour.toString().padLeft(2, '0')}:${formattedTime.minute.toString().padLeft(2, '0')}";
                                        });
                                      }
                                    },
                                    child: Icon(Icons.watch_later),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

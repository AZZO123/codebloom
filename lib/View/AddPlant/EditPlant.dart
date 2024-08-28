// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Model/Plant.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/AddPlant/Controller/EditPlantController.dart';
import 'package:palnt_app/View/AddPlant/EditSchedulePage.dart';
import 'package:palnt_app/View/Auth/Widgets/CustomTextField.dart';
import 'package:provider/provider.dart';

class EditPlant extends StatelessWidget {
  Plant? plant;
  EditPlant({this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<EditPlantController>(
        builder: (context, controller, child) => Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => controller.EditPlant(context),
                  child: Text("تعديل"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red)),
                  onPressed: () =>
                      controller.deletepalnt(controller.id_plant!, context),
                  child: Text("حذف"),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text("CodeBloom"),
      ),
      body: Consumer<EditPlantController>(
        builder: (context, controller, child) => ListView(
          padding: EdgeInsets.all(8),
          children: [
            Gap(5),
            Gap(20),
            CustomTextFieled(
              txt: 'اسم النبتة',
              controller: controller.plantname,
            ),
            Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.pickMultiimage(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBaseColor,
                        border: Border.all(color: kSecendryColor),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 0),
                            blurRadius: 7,
                            color: kBaseThirdyColor.withAlpha(100),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: controller.images.isEmpty &&
                                controller.plantold!.photo!.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("إضافة صور"),
                                  Icon(Icons.add),
                                ],
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("الصور القديمة"),
                                    Gap(10),
                                    if (controller.plantold!.photo!.isNotEmpty)
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        alignment: WrapAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        children: controller.plantold!.photo!
                                            .map(
                                              (e) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            'assets/images/Logo.png',
                                                        image:
                                                            "${AppApi.IMAGEURL}${e.photoUrl}",
                                                        fit: BoxFit.fill,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: GestureDetector(
                                                        onTap: () => controller
                                                            .removeimagefromapi(
                                                                e.id!, context),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kSecendryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: kBaseColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    Text("الصور الجديدة"),
                                    Gap(10),
                                    if (controller.images.isNotEmpty)
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        alignment: WrapAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        children: controller.images
                                            .map(
                                              (e) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.file(
                                                        File(e.path),
                                                        fit: BoxFit.fill,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: GestureDetector(
                                                        onTap: () => controller
                                                            .removeimageformlist(
                                                                e),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kSecendryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: kBaseColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        content: CustomTextFieled(
                          txt: 'معلومات النبتة',
                          controller: controller.plantinfo,
                          maxline: 4,
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                controller.notifyListeners();
                                CustomRoute.RoutePop(context);
                              },
                              child: Text("موافق")),
                          TextButton(
                              onPressed: () {
                                CustomRoute.RoutePop(context);
                              },
                              child: Text("إلغاء"))
                        ],
                      ),
                    ),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: kBaseColor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-5, 0),
                            blurRadius: 7,
                            color: kBaseThirdyColor.withAlpha(100),
                          )
                        ],
                        border: Border.all(color: kSecendryColor),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: controller.plantinfo.text == ''
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("معلومات النبتة"),
                                Gap(10),
                                Icon(Icons.add),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("معلومات النبتة"),
                                    Gap(10),
                                    Text("${controller.plantinfo.text}"),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
            Gap(10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => CustomRoute.RouteTo(
                        context,
                        EditSchedulePage(
                          controller: controller,
                        )),
                    child: Text("جدول النبتة"),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: StatefulBuilder(
                            builder: (context, setState) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: controller.titleController,
                                        decoration: InputDecoration(
                                          labelText: 'اسم التنبيه',
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await controller
                                              .selectDateTime(context);

                                          setState(() {});
                                        },
                                        child: Text('اختر التاريخ والوقت'),
                                      ),
                                      if (controller.selectedDateTime != null)
                                        Text(
                                            'التاريخ: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.selectedDateTime.toString()))}'),
                                      if (controller.selectedDateTime != null)
                                        Text(
                                            'الوقت: ${DateFormat('HH:mm a').format(DateTime.parse(controller.selectedDateTime.toString()))}'),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () =>
                                            controller.saveReminder(context),
                                        child: Text('حفظ التنبيه'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    label: Text("إضافة تنبيه جديد"),
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  content: CustomTextFieled(
                    txt: 'ملاحظة جديدة',
                    controller: controller.notecontroller,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          controller.addnotes();
                          CustomRoute.RoutePop(context);
                        },
                        child: Text("موافق")),
                    TextButton(
                        onPressed: () {
                          CustomRoute.RoutePop(context);
                        },
                        child: Text("إلغاء"))
                  ],
                ),
              ),
              label: Text("إضافة ملاحظة جديدة"),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (controller.listreminder.isNotEmpty) Text("التنبيهات"),
                      if (controller.listreminder.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemCount: controller.listreminder.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: kBaseThirdyColor.withAlpha(200),
                                        blurRadius: 10,
                                        offset: Offset(0, 0))
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                  color: kSecendryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.listreminder[index].title == ''
                                          ? "تنبيه عام"
                                          : controller
                                              .listreminder[index].title,
                                      style: TextStyle(
                                          color: kBaseColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gap(10),
                                    Text(
                                      '${DateFormat('yyyy-MM-dd HH:mm a').format(
                                        DateTime.parse(
                                          controller
                                              .listreminder[index].dateTime
                                              .toString(),
                                        ),
                                      )}',
                                      style: TextStyle(
                                          color: kBaseColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gap(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            kBaseColor)),
                                            onPressed: () {
                                              _showEditAlertDialog(
                                                  controller, context, index);
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: kSecendryColor,
                                            )),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            kBaseColor)),
                                            onPressed: () {
                                              controller.deleteAlert(index);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (controller.listnotes.isNotEmpty) Text("الملاحظات"),
                      if (controller.listnotes.isNotEmpty)
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemCount: controller.listnotes.length,
                          itemBuilder: (context, index) => GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemCount: controller.listnotes.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              kBaseThirdyColor.withAlpha(200),
                                          blurRadius: 10,
                                          offset: Offset(0, 0))
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: kSecendryColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.listnotes[index] == ''
                                            ? "تنبيه عام"
                                            : controller.listnotes[index],
                                        style: TextStyle(
                                            color: kBaseColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  kBaseColor)),
                                              onPressed: () {
                                                _showEditNoteDialog(
                                                    controller, context, index);
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: kSecendryColor,
                                              )),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  kBaseColor)),
                                              onPressed: () {
                                                controller.deleteNote(index);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _showEditNoteDialog(
    EditPlantController controller, BuildContext context, int index) {
  final TextEditingController noteController =
      TextEditingController(text: controller.listnotes[index]);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text('تعديل الملاحظة'),
        content: CustomTextFieled(
          txt: 'اكتب الملاحظة الجديدة',
          controller: noteController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.editNote(index, noteController.text);
              Navigator.of(context).pop();
            },
            child: Text('موافق'),
          ),
        ],
      );
    },
  );
}

void _showEditAlertDialog(
    EditPlantController controller, BuildContext context, int index) {
  final TextEditingController nameController =
      TextEditingController(text: controller.listreminder[index].title);
  final TextEditingController timeController = TextEditingController(
      text:
          DateFormat('HH:mm').format(controller.listreminder[index].dateTime));
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd')
          .format(controller.listreminder[index].dateTime));

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text('تعديل التنبيه'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieled(
              txt: 'اسم المنبه الجديد',
              controller: nameController,
            ),
            Gap(10),
            Text("الوقت"),
            TextField(
              controller: timeController,
              decoration: InputDecoration(hintText: 'ادخل الوقت الجديد'),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                      controller.listreminder[index].dateTime),
                );
                if (pickedTime != null) {
                  timeController.text = pickedTime.format(context);
                }
              },
            ),
            Gap(10),
            Text("التاريخ"),
            TextField(
              controller: dateController,
              decoration: InputDecoration(hintText: 'ادخل التاريخ الجديد'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.listreminder[index].dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.editAlert(index, nameController.text,
                  timeController.text, dateController.text);
              Navigator.of(context).pop();
            },
            child: Text('موافق'),
          ),
        ],
      );
    },
  );
}

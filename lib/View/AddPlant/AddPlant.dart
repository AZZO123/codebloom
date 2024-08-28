// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, must_be_immutable, use_key_in_widget_constructors

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Controller/Provier.dart';
import 'package:palnt_app/Model/Plant.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/AddPlant/Add_Alarm.dart';
import 'package:palnt_app/View/AddPlant/Controller/AddPlantController.dart';
import 'package:palnt_app/View/AddPlant/EditAlarm.dart';
import 'package:palnt_app/View/AddPlant/SchedulePage.dart';
import 'package:palnt_app/View/Auth/Widgets/CustomTextField.dart';
import 'package:palnt_app/main.dart';
import 'package:provider/provider.dart';

class AddPlant extends StatefulWidget {
  Plant? plant;
  AddPlant({this.plant});

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  @override
  void initState() {
    context.read<alarmprovider>().GetData();
    super.initState();
  }

  String? dateTime;

  bool repeat = false;

  DateTime? notificationtime;

  String? name = "none";

  int? Milliseconds;

  @override
  Widget build(BuildContext context) {
    AlarmProvider = Provider.of<alarmprovider>(context);

    return Scaffold(
      bottomNavigationBar: Consumer<AddPlantController>(
        builder: (context, controller, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => controller.AddPlant(context),
            child: Text("إضافة"),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text("CodeBloom"),
      ),
      body: Consumer<AddPlantController>(
        builder: (context, controller, child) => ListView(
          padding: EdgeInsets.all(8),
          children: [
            Gap(5),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 15),
                autoPlayAnimationDuration: Duration(seconds: 3),
                height: 200,
              ),
              items: widget.plant!.tips == null
                  ? [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 0),
                                color: kBaseThirdyColor.withAlpha(150),
                              )
                            ],
                            color: kBaseColor,
                            border: Border.all(color: kSecendryColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "لايوجد توصيات لهذا النوع",
                                style: TextStyle(fontSize: 16.0),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )),
                    ]
                  : widget.plant!.tips!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    color: kBaseThirdyColor.withAlpha(150),
                                  )
                                ],
                                color: kBaseColor,
                                border: Border.all(color: kSecendryColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  '$i',
                                  style: TextStyle(fontSize: 16.0),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ));
                        },
                      );
                    }).toList(),
            ),
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
                        child: controller.images.isEmpty
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
                                    Text("الصور"),
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
                        SchedulePage(
                          controller: controller,
                        )),
                    child: Text("جدول النبتة"),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () => CustomRoute.RouteTo(
                        context,
                        AddAlarm(
                          controller: controller,
                        )),
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
                                              CustomRoute.RouteTo(
                                                  context,
                                                  EditAlaram(
                                                    controller: controller,
                                                    reminder: controller
                                                        .listreminder[index],
                                                    index: index,
                                                  ));
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
                                            ? "ملاحظة فارغة"
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
    AddPlantController controller, BuildContext context, int index) {
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

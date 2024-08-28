// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Model/Plant.dart';

class PlantDetailes extends StatelessWidget {
  PlantDetailes({this.plant});
  Plant? plant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant!.name!),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: kBaseColor,
                border: Border.all(color: kSecendryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  plant!.assetpath!,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("الاسم:"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(plant!.name!),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("النوع:"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(plant!.type!),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("الاسم العلمي:"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(plant!.scientificName!),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: plant!.tips!
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.circle,
                              size: 15,
                            ),
                          ),
                          Expanded(child: Text(e)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

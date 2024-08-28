import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:palnt_app/Constant/Lists.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Constant/url.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/AddPlant/AddPlant.dart';
import 'package:palnt_app/View/AddPlant/Controller/AddPlantController.dart';
import 'package:palnt_app/View/AddPlant/Controller/EditPlantController.dart';
import 'package:palnt_app/View/AddPlant/EditPlant.dart';
import 'package:palnt_app/View/MyCollection/Controller/MyCollectionController.dart';
import 'package:palnt_app/main.dart';
import 'package:provider/provider.dart';

class MyCollection extends StatefulWidget {
  const MyCollection({super.key});

  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await collectionController.getplants();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    collectionController = Provider.of<MyCollectionController>(context);

    return Scaffold(
      body: Consumer<MyCollectionController>(
        builder: (context, controller, child) => ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Gap(5),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 15),
                autoPlayAnimationDuration: Duration(seconds: 3),
                height: 200,
              ),
              items: listdataslider.map((i) {
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
                          child: Text(
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
            GridView.builder(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemCount: collectionController.listplant.length + 1,
              itemBuilder: (context, index) {
                if (index < collectionController.listplant.length) {
                  return GestureDetector(
                    onTap: () => CustomRoute.RouteTo(
                      context,
                      ChangeNotifierProvider<EditPlantController>(
                        create: (context) => EditPlantController()
                          ..oninit(
                              collectionController.listplant[index].plantType)
                          ..loadPlantData(
                              collectionController.listplant[index]),
                        builder: (context, child) => EditPlant(),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBaseColor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            color: kBaseThirdyColor.withAlpha(150),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: kBaseColor,
                                        border:
                                            Border.all(color: kSecendryColor),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: collectionController
                                                .listplant[index].photo!.isEmpty
                                            ? Image.asset(
                                                'assets/images/Logo.png')
                                            : FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/Logo.png',
                                                image:
                                                    "${AppApi.IMAGEURL}${collectionController.listplant[index].photo![0].photoUrl!}",
                                                height: 200,
                                                fit: BoxFit.fill,
                                                imageErrorBuilder: (context,
                                                        error, stackTrace) =>
                                                    Image.asset(
                                                        'assets/images/Logo.png'),
                                              ),
                                      )),
                                )),
                              ],
                            ),
                          ),
                          Text(
                            '${collectionController.listplant[index].plantName}',
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: Text(
                                  "اختر نوع النبتة المرغوب إضافتها",
                                ),
                                content: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: listplantforadd
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      CustomRoute.RouteTo(
                                                          context,
                                                          ChangeNotifierProvider<
                                                              AddPlantController>(
                                                            create: (context) =>
                                                                AddPlantController()
                                                                  ..oninit(
                                                                      e.name),
                                                            builder: (context,
                                                                    child) =>
                                                                AddPlant(
                                                              plant: e,
                                                            ),
                                                          ));
                                                    },
                                                    child: Text(e.name!)),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                          label: Text("إضافة نبتة جديدة"),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:palnt_app/Constant/Lists.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Services/Routes.dart';
import 'package:palnt_app/View/Encyclopedia/PlantDetailes.dart';

class EncyclopediaPage extends StatelessWidget {
  const EncyclopediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: listplant.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => CustomRoute.RouteTo(
            context,
            PlantDetailes(
              plant: listplant[index],
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
                              border: Border.all(color: kSecendryColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                listplant[index].assetpath!,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )),
                      )),
                    ],
                  ),
                ),
                Text(
                  '${listplant[index].name}',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

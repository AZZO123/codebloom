import 'package:palnt_app/Controller/Provier.dart';
import 'package:palnt_app/Controller/ServicesProvider.dart';
import 'package:palnt_app/View/MyCollection/Controller/MyCollectionController.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> listproviders = [
  ChangeNotifierProvider<ServicesProvider>(
    create: (context) => ServicesProvider(),
  ),
  ChangeNotifierProvider<MyCollectionController>(
    create: (context) => MyCollectionController(),
  ),
  ChangeNotifierProvider<alarmprovider>(
    create: (context) => alarmprovider(),
  )
];

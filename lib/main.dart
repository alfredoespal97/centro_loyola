import 'package:centroloyolapp/controller/global_controller.dart';
import 'package:centroloyolapp/models/estudiante_model.dart';
import 'package:centroloyolapp/pages/add_estudiante.dart';
import 'package:centroloyolapp/pages/add_registro.dart';
import 'package:centroloyolapp/pages/home_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home.dart';

void main() {
  Get.put(GlobalController());
  Get.lazyPut(()=>GlobalController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
  // This widget is the root of your application.

}

class _MyAppState extends State<MyApp> {
  final controller = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Centro Loyola',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Centro Loyola'),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => MyHomePage()),
          // GetPage(name: '/', page: () => MyDashBoard(), binding: DashBoardBinding()),
          // GetPage(name: '/home', page: () => const HomePage()),
          GetPage(name: '/add_registro', page: () => AddRegistroPage()),
          //GetPage(name: '/add_estudiante', page: () => AddEstudiantePage()),
         // GetPage(name: '/list_estudiante', page: () => HomeEstudiantePage(registro: null,)),
        ]);
  }
}

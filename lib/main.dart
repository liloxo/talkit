import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirshop/core/functions/initialbinding.dart';
import 'package:mirshop/core/services/services.dart';
import 'package:mirshop/routes.dart';
//import 'package:mirshop/testing.dart';
import 'package:mirshop/view/auth/signup.dart';
import 'package:mirshop/view/home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      home: myServices.sharedPreferences.getString('signed') == '1' ? const HomePage() : const SignUp(),
      //home: const Testing(),
      debugShowCheckedModeBanner: false,
      getPages: routes,
    );
  }
}
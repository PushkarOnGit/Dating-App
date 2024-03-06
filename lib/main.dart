import 'package:bliss_bond/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDEnPCQUNVkyl74I2sRM_KKSKx7TuGAvIY",
      appId: "1:323534993891:android:7ae201a907526a0d1088d6",
      messagingSenderId: "323534993891",
      projectId: "blissbond-a9523",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

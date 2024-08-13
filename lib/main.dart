import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/Wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD-2QqAZh3-m_7RxbVkuZd9EtS7Lp0ZpGw",
          messagingSenderId: "919424416673",
          projectId: "fir-1d22f",
          appId: "1:919424416673:web:23860aa6a075ddccf8a9e0",
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUNFACE',
      debugShowCheckedModeBanner:false ,
      home: Wrapper(),
    );
  }
}


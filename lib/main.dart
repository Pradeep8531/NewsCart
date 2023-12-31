import 'package:flutter/material.dart';
import 'package:newscartz/login_signup/Auth_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newscartz/views/profile/profilepage.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: ProfilePage(),//Authpage(),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newscartz/login_signup/loginandsignup.dart';
import '../views/homepage.dart';


class Authpage extends StatelessWidget {
  const Authpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapsshot){
          if(snapsshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          else{
            if (snapsshot.hasData){
              return HomePage();
            }
            else{
              return const loginandsignup();
            }
          }
        },
      ),
    );
  }
}

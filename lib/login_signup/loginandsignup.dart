import 'package:flutter/material.dart';
import 'package:newscartz/login_signup/login.dart';
import 'package:newscartz/login_signup/signup.dart';


class loginandsignup extends StatefulWidget {
  const loginandsignup({Key? key}) : super(key: key);

  @override
  State<loginandsignup> createState() => _loginandsignupState();
}

class _loginandsignupState extends State<loginandsignup> {
  bool isLogin = true;
  void togglepage(){
    setState(() {
      isLogin = !isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isLogin){
      return login(onPressed: togglepage,);
    }
    else{
      return signup(onPressed: togglepage,);
    }

  }
}

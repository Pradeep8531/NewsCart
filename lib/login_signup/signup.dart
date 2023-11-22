import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
class signup extends StatefulWidget {
  final void Function()? onPressed;
  const signup({Key? key, this.onPressed}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final _formKey =  GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  createUserWithEmailAndPassword() async{
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,

      );
      setState(() {
        isLoading = false;
      });
    }  on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The password provided is too weak"),),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The account already exists for that email."),),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(child: Text("News ", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 80),)),
                    Container(child: Text("Cart", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 45),)),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OverflowBar(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (text){
                          if (text == null || text.isEmpty){
                            return 'Email is Empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (text){
                          if (text == null || text.isEmpty){
                            return 'Password is Empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: "Password"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child:
                        SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  createUserWithEmailAndPassword();
                                }
                              }, child:isLoading?Center(child: const CircularProgressIndicator( color: Colors.white,))
                                :  const Text("Sign Up"),
                            )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 45,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              ),
                              onPressed: widget.onPressed,
                              child:const Text("Login"),
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newscartz/login_signup/login.dart';
import '../Custom_News_Selection.dart';
import '../categorylist.dart';
import '../homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  String? _userName;
  String? _userEmail;
  String? _userPhotoURL;
  String? _userPhoneNumber; // Placeholder for the phone number

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _userName = user.displayName;
        _userEmail = user.email;
        _userPhotoURL = user.photoURL;
        // Placeholder: Retrieve the user's phone number based on your authentication setup
        _userPhoneNumber = '+1234567890';
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
      }
      if(index == 2){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Custom_News_Selection()));
      }
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Text("News ", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),),
            Text("Cart", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_userPhotoURL != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_userPhotoURL!),
              ),
            SizedBox(height: 20),
            if (_userName != null)
              Text(
                'Name: $_userName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (_userEmail != null)
              Text(
                'Email: $_userEmail',
                style: TextStyle(fontSize: 16),
              ),
            if (_userPhoneNumber != null)
              Text(
                'Phone Number: $_userPhoneNumber',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Custom',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newscartz/views/Custom_News.dart';
import 'categorylist.dart';
import 'homepage.dart';


class Custom_News_Selection extends StatefulWidget {
  const Custom_News_Selection({Key? key}) : super(key: key);

  @override
  State<Custom_News_Selection> createState() => _Custom_News_SelectionState();
}

class _Custom_News_SelectionState extends State<Custom_News_Selection> {

  int _selectedIndex = 2;
  String country = "us";
  String category = "business";

  String selectedCountry = "us";

  var countries = {

    "ar": "Argentina",
    "at": "Austria",
    "au": "Australia",
    "be": "Belgium",
    "bg": "Bulgaria",
    "br": "Brazil",
    "ca": "Canada",
    "ch": "Switzerland",
    "cn": "China",
    "co": "Colombia",
    "cu": "Cuba",
    "cz": "Czech Republic",
    "de": "Germany",
    "eg": "Egypt",
    "fr": "France",
    "gb": "United Kingdom",
    "gr": "Greece",
    "hk": "Hong Kong",
    "hu": "Hungary",
    "id": "Indonesia",
    "ie": "Ireland",
    "il": "Israel",
    "in": "India",
    "it": "Italy",
    "jp": "Japan",
    "kr": "South Korea",
    "lt": "Lithuania",
    "lv": "Latvia",
    "ma": "Morocco",
    "mx": "Mexico",
    "my": "Malaysia",
    "ng": "Nigeria",
    "nl": "Netherlands",
    "no": "Norway",
    "nz": "New Zealand",
    "ph": "Philippines",
    "pl": "Poland",
    "pt": "Portugal",
    "ro": "Romania",
    "rs": "Serbia",
    "ru": "Russia",
    "sa": "Saudi Arabia",
    "se": "Sweden",
    "sg": "Singapore",
    "si": "Slovenia",
    "sk": "Slovakia",
    "th": "Thailand",
    "tr": "Turkey",
    "tw": "Taiwan",
    "ua": "Ukraine",
    "ae": "United Arab Emirates",
    "us": "United States",
    "ve": "Venezuela",
    "za": "South Africa",
  };
  var categories = {
    'business': 'Business',
    'entertainment': 'Entertainment',
    'general': 'General',
    'health': 'Health',
    'sciences': 'Sciences',
    'sports': 'Sports',
    'technology': 'Technology',
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
      }
    });
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
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.login), color: Colors.black87,)
        ],
      ),
      body: Container(
        color: Colors.blue.shade500,
        child: Center(
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60, top: 10, bottom: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          elevation: 0,
                          value: selectedCountry,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                            });
                          },
                          items: countries.keys.map<DropdownMenuItem<String>>((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(countries[key]!),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  //item2
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60, top: 10, bottom: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          value: category,
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
                            });
                            },
                          items: categories.keys.map<DropdownMenuItem<String>>((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Row(
                                children: [
                                  Text(categories[key]!),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Custom_News_View(
                          newsCategory: category,
                          country: selectedCountry,
                        )));
                      },
                        child: Text("GO"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
                        ),

                      ),
                    ),
                  ),
                ],
              ),
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
            icon: Icon(Icons.person),
            label: 'Custom',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade500,
        onTap: _onItemTapped,
      ),
    );
  }
}

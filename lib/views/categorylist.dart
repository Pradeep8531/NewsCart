import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newscartz/views/Custom_News_Selection.dart';
import 'package:newscartz/views/homepage.dart';
import '../helper/data.dart';
import '../models/categorie_model.dart';
import 'categorie_news.dart';

/// List of Categories Page Categories page


class categorylist extends StatefulWidget {

  const categorylist({Key? key}) : super(key: key);

  @override
  State<categorylist> createState() => _categorylistState();
}

class _categorylistState extends State<categorylist> {

  int _selectedIndex = 1;
  List<CategorieModel> categories = <CategorieModel>[];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      if(index == 2){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Custom_News_Selection()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categories = getCategories();
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
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryCard(
                  imageAssetUrl: categories[index].imageAssetUrl,
                  categoryName: categories[index].categorieName,
                ),
              );
            }),
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
        selectedItemColor: Colors.blue.shade500,
        onTap: _onItemTapped,
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final imageAssetUrl, categoryName;
  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

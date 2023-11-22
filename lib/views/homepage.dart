import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newscartz/helper/data.dart';
import 'package:newscartz/helper/widgets.dart';
import 'package:newscartz/models/categorie_model.dart';
import 'package:newscartz/views/categorie_news.dart';
import 'package:newscartz/views/categorylist.dart';
import '../helper/news.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late bool _loading;
  var newslist;
  int _selectedIndex = 0;

  List<CategorieModel> categories = <CategorieModel>[];

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => categorylist()));
      }
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children:[
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
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Today's ",style: TextStyle(fontSize: 40,),),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Top News",style: TextStyle(fontSize: 20,),),
                            ),
                          ],
                        ),
                      ),
                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].url ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
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
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
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
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helper/news.dart';
import '../helper/widgets.dart';
import 'categorylist.dart';
import 'homepage.dart';

///Custom News View


class Custom_News_View extends StatefulWidget {
  final newsCategory;
  final country;
  const Custom_News_View({Key? key, this.newsCategory, this.country}) : super(key: key);

  @override
  State<Custom_News_View> createState() => _Custom_News_ViewState();
}

class _Custom_News_ViewState extends State<Custom_News_View> {

  var newslist;
  bool _loading = true;
  int _selectedIndex = 2;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
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
    });
  }

  void getNews() async {
    NewsForCategorie_Country news = NewsForCategorie_Country();
    await news.getNewsForCategory_Country(widget.country,widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
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
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : newslist.isEmpty
          ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty_outlined, color: Colors.grey, size: 90, ),
            Center(
              child: Text(
                'Sorry, No news available at the moment',
                style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),
              ),
            ),
          ]
      )
          : SingleChildScrollView(
        child: Container(
          child: Container(
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

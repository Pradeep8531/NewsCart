import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';



class ArticleView extends StatefulWidget {

  final String postUrl;
  ArticleView({required this.postUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  // final controller = WebViewController()
  // ..setJavaScriptMode(JavaScriptMode.disabled);
  // //..loadRequest (Uri.parse(postUrl));
  // final Completer<WebViewController> _controller = Completer<WebViewController>();


  late InAppWebViewController inAppWebViewController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const <Widget>[
            Text("News", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),),
            Text("Cart", style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(widget.postUrl)
            ),
            onWebViewCreated: (InAppWebViewController controller){
              inAppWebViewController = controller;
            },
            onProgressChanged: (InAppWebViewController controller, int progress){
              setState(() {
              });
            },
          ),
        ]
      )
    );
  }
}

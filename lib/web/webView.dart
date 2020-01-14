import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {

  final Map arguments;

  WebViewPage({Key key,this.arguments}) : super(key: key);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    // print("=========${widget.arguments["url"]}");
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(widget.arguments["title"]),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: this._progress<1.0?LinearProgressIndicator(
                value: this._progress,
                backgroundColor: Colors.white,
              ):Container(),
            ),
            Expanded(
              child: InAppWebView(
                initialUrl: widget.arguments["url"],
                initialHeaders: {},
                initialOptions: InAppWebViewWidgetOptions(),
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  setState(() {
                    this._progress = progress / 100;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
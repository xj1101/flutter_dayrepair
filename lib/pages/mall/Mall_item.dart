import 'package:dayrepair/services/XJExtension.dart';
import 'package:flutter/material.dart';

class MallItemPage extends StatefulWidget {

  double width = 100;
  double height = 100;
  //"https://www.itying.com/images/flutter/1.png"
  String imageUrl = "";
  String name = "";
  String price = "0";
  Object cb;
  MallItemPage({Key key,this.width,this.height,this.imageUrl,this.name,this.price,this.cb=null}) : super(key: key);

  _MallItemPageState createState() => _MallItemPageState();
}

class _MallItemPageState extends State<MallItemPage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.cb,
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Color.fromARGB(20, 0, 0, 0),
            )
          ],
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: AspectRatio(
                aspectRatio: 1/1,
                child: Image.network(widget.imageUrl,fit: BoxFit.cover,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(widget.name,maxLines: 2,overflow: TextOverflow.ellipsis,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text("￥${widget.price}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,style: TextStyle(
                  color: TextColor.drBrightTextColor
                )),
            )
          ],
        ),
      ),
    );
  }
}
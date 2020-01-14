import 'package:flutter/material.dart';

class XJButton extends StatelessWidget {

  final Color color; //背景颜色
  final String text; //文字
  final Object cb;
  final double height; //高度
  final double fontSize; //文字大小
  final EdgeInsetsGeometry margin;
  final double radius; //圆角大小
  
  const XJButton(
    {
      Key key,
      this.color=Colors.black,
      this.text="按钮",
      this.cb=null,
      this.height=60.0,
      this.fontSize=14.0,
      this.margin=null,
      this.radius=10
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.cb,
      child: Container(
        margin: margin==null?EdgeInsets.fromLTRB(10, 5, 10, 10):margin,
        padding: EdgeInsets.all(5),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius)
        ),
        child: Center(
          child: Text(text,style: TextStyle(
            color: Colors.white,
            fontSize: fontSize
          )),
        ),
      ),
    );
  }
}

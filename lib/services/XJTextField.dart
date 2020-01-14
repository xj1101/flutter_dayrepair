import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../services/ScreenAdaper.dart';

class XJTextField extends StatelessWidget {

  final String text;
  final bool password;
  final Object onChanged;
  final int maxLines;
  final double height;
  final int maxLength;
  final String content;
  final FocusNode focusNode;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;

  XJTextField({Key key,this.text="输入内容",this.password=false,this.onChanged=null,this.maxLines=1,this.height=68,this.maxLength=null,this.content=null,this.focusNode=null,this.controller=null,this.inputFormatters=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller:controller,
        maxLines:this.maxLines ,
        obscureText: this.password,
        keyboardType: TextInputType.number,
        maxLength: this.maxLength,
        inputFormatters: this.inputFormatters,
        decoration: InputDecoration(
          labelText: this.content,
          hintText: this.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none
          ),
          hintStyle: TextStyle(
            fontSize: ScreenAdaper.size(28)
          ),
        ),
        onChanged: this.onChanged,
        focusNode: this.focusNode,
      ),
      height: ScreenAdaper.height(this.height),
      decoration: BoxDecoration(      
        border: Border(
          bottom: BorderSide.none
        )
      ),
    );
  }
}

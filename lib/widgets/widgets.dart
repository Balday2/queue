import 'package:flutter/material.dart';

class WidgetUi {

  // button ui design
  Widget button({required Widget child, double elevation =0.0, borderColor = Colors.transparent, onPressed,shape = 0.0, Color shadow = Colors.transparent, Color bColor = Colors.blue,Color overColor = Colors.transparent, double width = 200.0, double height = 60.0, double border = 0.0}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        animationDuration: const Duration(milliseconds: 200),
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(bColor),
        elevation: MaterialStateProperty.all(elevation),
        minimumSize: MaterialStateProperty.all(Size(width,height)),
        overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
        shadowColor: MaterialStateProperty.all(shadow),
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shape), 
          side: BorderSide(width: border, color: borderColor),
        )),
      ),
      child: child,
    );
  }
}
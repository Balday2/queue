import 'package:flutter/material.dart';

class WidgetUi {

  /// button ui design
  Widget button(
      {required Widget child,
      double elevation = 0.0,
      outlineColor = Colors.transparent,
      isLoading = false,
      onPressed,
      shape = 0.0,
      Color shadow = Colors.transparent,
      Color color = Colors.blue,
      Color overColor = Colors.black,
      double width = 200.0,
      double height = 60.0}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 200),
          enableFeedback: true,
          backgroundColor: MaterialStateProperty.all(color),
          elevation: MaterialStateProperty.all(elevation),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
          shadowColor: MaterialStateProperty.all(shadow),
          visualDensity: VisualDensity.comfortable,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(shape),
            side: BorderSide(width: 1.0, color: outlineColor),
          )),
        ),
        child: isLoading ? circularProgress() : child);
  }


    SizedBox circularProgress({tick = 2.0, color = Colors.white, size = 25.0}) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
          strokeWidth: tick, valueColor: AlwaysStoppedAnimation<Color>(color)),
    );
  }
}
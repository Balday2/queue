import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthWidget {

  Widget inputForm(String label,{
    required Function(String? v) validate, required Function(String? v) onChange,
    maxLines = 1,
    TextInputAction nextInput = TextInputAction.done,
    type = TextInputType.text,
    iconL,
    iconR,
    showPwd = false,
    thousandFormat =false,
    controller,
    initVal, 
    textAlign = TextAlign.start,
    letterSpacing = 1.0,
    border =false
  }) {
    return TextFormField(
      initialValue: initVal,
      keyboardType: type,
      obscureText: showPwd,
      textAlign: textAlign,
      textInputAction: nextInput,
      maxLines: maxLines,
      style: TextStyle(
        height:1.8,
        letterSpacing: letterSpacing
      ),
      decoration: InputDecoration(

          border: InputBorder.none,
          
          hintText: label,
          prefixIcon: iconL,
          suffixIcon: iconR,
          hintStyle: TextStyle(
            color: Vx.gray500,
            fontSize: 15.0,
            letterSpacing: letterSpacing,
            fontWeight: FontWeight.bold
          ),
          filled: true,
          fillColor: Vx.gray300
      ),
      validator: (value) => validate(value),
      onChanged: (value) => onChange(value),
      controller: controller,
    );
  }
}
import 'package:flutter/material.dart';


class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 39, 149, 176)
          ),
        ),
        focusedBorder: UnderlineInputBorder(
           borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 39, 149, 176),
            width: 2
          )
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 230, 230, 230),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),

        prefixIcon: prefixIcon != null 
          ? Icon( prefixIcon, color: Color.fromARGB(255, 39, 149, 176) )
          : null
      );
  }  

}
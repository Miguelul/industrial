import 'package:flutter/material.dart';


class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.deepPurple
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2
          )
        ),
        filled: true,
        fillColor: const Color.fromARGB(
                                        255, 238, 238, 238),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey
        ),

        prefixIcon: prefixIcon != null 
          ? Icon( prefixIcon, color: Colors.deepPurple )
          : null
      );
  }  

}
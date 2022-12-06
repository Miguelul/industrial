import 'package:flutter/material.dart';


class NotificationsService {


  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();


  static showSnackbar( String message ) {

    final snackBar = SnackBar(
      content: Text( message, style: const TextStyle( color: Color.fromARGB(255, 87, 87, 87), fontSize: 15)),
    duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.00),
        ),
      ),
      behavior: SnackBarBehavior.floating,
 dismissDirection: DismissDirection.up
    );

    messengerKey.currentState!.showSnackBar(snackBar);

  }


}
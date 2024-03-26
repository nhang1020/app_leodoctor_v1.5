import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

class MyNotifications {
  SnackBar successSnackBar(String content) {
    return SnackBar(
      backgroundColor: themeModeColor,
      content: Text(
        '✓ ${content}',
        style: TextStyle(color: Color.fromARGB(255, 40, 176, 85)),
      ), // Width of the SnackBar.
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  SnackBar errorSnackBar(String content) {
    return SnackBar(
      backgroundColor: themeModeColor,
      content: Text(
        '⚠ ${content}',
        style: TextStyle(color: Colors.red),
      ), // Width of the SnackBar.
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  SnackBar warningSnackBar(String content) {
    return SnackBar(
      backgroundColor: themeModeColor,
      content: Text(
        '⚠ ${content}',
        style: TextStyle(color: Colors.blueAccent),
      ), // Width of the SnackBar.
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

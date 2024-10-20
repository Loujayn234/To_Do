import 'package:flutter/material.dart';

class Cancelbutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  Cancelbutton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: const Color.fromARGB(255, 241, 19, 19),
      textColor: Colors.white,
    );
  }
}

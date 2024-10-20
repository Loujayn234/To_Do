// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Start a timer for 5 seconds to navigate to the main page
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 121, 114, 219),
            const Color.fromARGB(255, 81, 56, 157)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
              child: Image.asset(
                'lib/assets/toDo2.jpg', // Path to your image
                width: 200.0, // Adjust width as needed
                height: 200.0, // Adjust height as needed
                fit:
                    BoxFit.cover, // Ensures the image fits within the container
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Start To-Doing',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

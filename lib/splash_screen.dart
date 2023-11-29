import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'helper/style.dart';
import 'home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  String logo = 'assets/film.png';
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    redirect();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(logo),
                ),
              ),
            ),
          ),
          // Loading indicator
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  redirect() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );

  }
}

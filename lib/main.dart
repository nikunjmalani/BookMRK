import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: MaterialApp(
        title: 'BookMRK',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

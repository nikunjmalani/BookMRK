import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/login_provider.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/provider/reset_password_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// new push from the backend branch...
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResetPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VendorProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'BookMRK',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/location_name_provider.dart';
import 'package:bookmrk/provider/login_provider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/provider/reset_password_provider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// new push from the backend branch...
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SchoolProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductOrderProvider(),
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

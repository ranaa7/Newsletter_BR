import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:newsletter_blueribbon_task/modules/newsletter/providers/preferences_provider.dart';
import 'package:provider/provider.dart';

import 'data/local/theme.dart';
import 'modules/authentication/registration/providers/auth_provider.dart';
import 'modules/authentication/registration/screens/signup_screen.dart';
import 'modules/newsletter/providers/categories_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((_) {
    AuthProvider().handleDeepLinks();
  });
  final themeController = ThemeController();
  await themeController.loadTheme();


  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),

  ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(),

        ),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
      ],child:  MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),

    );
  }
}



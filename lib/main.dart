import 'package:emartappyou/consts/consts.dart';
import 'package:emartappyou/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    // Replace with actual values
    options:const  FirebaseOptions(
      apiKey: "AIzaSyDdFyhTG-P66Bbw7LrfluoLS35pxrg803g",
      appId: "emart-77894",
      messagingSenderId: "257233505973",
      projectId: "emart-77894",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key?key}) : super (key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // we are using get x so we have to change this material app getmaterielapp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          // to set app bar icon color
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent
          ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    






 
 
 

 
 
 
 

 

 
 



 

 
 
 
 
 
 
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


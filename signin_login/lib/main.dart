import 'package:flutter/material.dart';
import 'package:signin_login/features/screens/Login.dart';
import 'package:signin_login/features/screens/dashboard.dart';
import 'package:signin_login/features/screens/signup.dart';
import 'package:signin_login/features/screens/welcomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  //Connecting to firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),

      //StreamBuilder: Firebase authentication
      /**home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChange(),
          builder: (context, snapshot){
            if (snapshot.hasData){
              return DashboardScreen();
            } else {
              return  LoginScreen();
            }
          }
      )*/

    );
  }
}


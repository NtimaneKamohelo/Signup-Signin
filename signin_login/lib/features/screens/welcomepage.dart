import 'package:flutter/cupertino.dart';
import  'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signin_login/features/screens/Login.dart';
import 'package:signin_login/features/screens/signup.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return welcomepageMethod(context);
  }

  Scaffold welcomepageMethod(BuildContext context) {
    return Scaffold(

    body: Center(
      child: Stack(
        children: [
          //Background image
          Container( //First Container
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/welcome-planeImage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),


          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              //Text over the background image
              Container( //Second container
                padding: EdgeInsets.only(top: 150),
                alignment: Alignment.center,

                child: const Text("WELCOME",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    //fontFamily: ''
                  ),
                ),
              ),

              const Text("This is your one stop to booking your next private trip",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    //Login button
                    Container(

                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54,
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),


                          ),
                          child: Text("login".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black87,
                            ),

                          ),
                        ),

                    ),
                    //Signup button
                    Container(
                        child: ElevatedButton(
                            onPressed: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()),),
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          ),
                            child: Text("signup".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),),),
                  ],
                ),
              )
            ],

          ),


        ],
      )
    ),

  );
  }
}

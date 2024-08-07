import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signin_login/features/screens/dashboard.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //Declare variables to be entered
  String firstName = "";
  String surname = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  //TextEditingController: Retrieve data from the textfield
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    }on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "No user found for that username",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        );
      } else if (e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Wrong password provided',
            style: TextStyle(fontSize: 18),
          ),
        ));
      }

    }
  }

  //Registration: this function is called whenever a user clicks on the signup button
  registration() async {
    if (password != null && password != confirmPassword && firstNameController.text.isNotEmpty && surnameController.text.isNotEmpty && emailController.text.isNotEmpty){
      try{
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
      on FirebaseAuthException catch(e) {
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password provided is too weak",
              style: TextStyle(fontSize: 18.0),
            )));
        }
        else if (e.code == "email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already Exist",
                style: TextStyle(
                  fontSize: 18.0
                )
              )));
        }
        else if (password != confirmPasswordController){
          if (e.code == "password_dont_match"){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                    "Password don' match",
                    style: TextStyle(
                        fontSize: 18.0
                    )
                )));
          }
        }
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text(
          "Sign-Up Screen".toUpperCase(),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //First Name Text Field
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),

                  //Converted the TextFields into TextFormField
                  //Allows the textfield to validated the case if whether
                  //The user entered a value
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your firstname";
                      }
                      return null;
                    },
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      labelText: "FirstName",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),

                      hintText: "First Name",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),

                      //How to add an icon in a text field
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),

                //Surname text field
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your surname";
                      }
                      return null;
                    },
                    controller: surnameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      labelText: "Surname",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),

                      hintText: "Surname",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),

                      prefixIcon: Icon(Icons.person),

                    ),
                  ),
                ),

                //Email Textfield
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your E-mail address";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),

                      hintText: "E-mail",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),

                //Password Text Field
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your password";
                      }
                      return null;
                    },
                    //obscureText: !_passwordVisible,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),

                      //Icons
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),

                    ),
                  ),
                ),

                //Confirm Password Text Field
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please Confirm your password";
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),

                      //Icons
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),

                    ),
                  ),
                ),

                //This button lets the use user register their account
                //Wrap the SignUp container in a GestureDetector widget
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        firstName = firstNameController.text;
                        surname = surnameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                      });
                    }
                    registration();
                  },
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Center(
                      child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500
                          ),
                      ),
                    ),

                    /**margin: const EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: EdgeInsets.symmetric(horizontal: 100.0)
                      ),
                      child: Text("signup".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19
                        ),
                      ),
                    ),*/
                  ),
                )

                //Sign-up using google



              ],
            ),
          ),
        ),
      ),
    );
  }
}





/**class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       backgroundColor: Colors.greenAccent,
       title: Text(
         "Sign-Up Screen".toUpperCase(),
         style: const TextStyle(
           color: Colors.black87,
           fontWeight: FontWeight.bold,
         ),
       ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              //First Name Text Field
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
          
          
                    labelText: "FirstName",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
          
                    hintText: "First Name",
                    hintStyle: TextStyle(
                      color: Colors.black12,
                    ),
          
                    //How to add an icon in a text field
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
          
              //Surname text field
              Container(
                margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
          
                      labelText: "Surname",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
          
                      hintText: "Surname",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
          
                      prefixIcon: Icon(Icons.person),
          
                    ),
                  ),
              ),
          
              //Email Textfield
              Container(
                margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
          
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
          
                    hintText: "E-mail",
                    hintStyle: TextStyle(
                      color: Colors.black12,
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
          
              //Password Text Field
              Container(
                margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child:const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
          
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black12,
                    ),
          
                    //Icons
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
          
                  ),
                ),
              ),
          
              //Confirm Password Text Field
              Container(
                margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child:const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
          
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                      color: Colors.black12,
                    ),
          
                    //Icons
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
          
                  ),
                ),
              ),
          
              //This button lets the use user register their account
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton(
                    onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 100.0)
          
          
                  ),
          
                    child: Text("signup".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19
                      ),
                    ),
                ),
              )

              //Sign-up using google

          
          
            ],
          ),
        ),
      ),
    );
  }
}*/

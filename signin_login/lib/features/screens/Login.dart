import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String username = "";
  String password = "";

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
    on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("User doesn't exist"),));
      }
      else if (e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong password inserted",
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text("Login".toUpperCase(),
          style:   const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //Username text field
                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your username";
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      hintText: "Enter Username",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Username",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),

                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),

                //Password text field
                Container(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter password";
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),

                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),

                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),

                //Forgot password message
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Container(
                      child: TextButton(
                        onPressed: () => {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(right: 20.0),

                          //backgroundColor: Colors.white10,
                          //backgroundBuilder: EdgeInsets.only(right: 20.0),
                        ),
                        child: const Text("Forgot your Password?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //Login button
                GestureDetector(
                  onTap: (){
                    if (_formkey.currentState!.validate()){
                      setState(() {
                        username = usernameController.text;
                        password = passwordController.text;
                      });
                    }
                    userLogin();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen())),
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: const EdgeInsets.symmetric(horizontal:  100.0),
                        ),

                          child: Text("login".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                      ),
                  ),
                ),

                //Google LogIn button
                /**const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("OR"),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          onPressed: () => {},
                          child: child),
                    ),
                  ],
                ),*/

                Container(
                  child: Text("OR",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(

                    icon: const Image(
                      image: AssetImage(
                        "assets/icons/google-login-icon.png"),
                        width: 20,
                    ),
                    onPressed: () => {},
                    label: const Text("Log-In using Google",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),

                  ),

                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

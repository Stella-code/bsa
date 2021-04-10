import 'package:bsa/home.dart';
import 'package:bsa/reset.dart';
import 'package:bsa/verify.dart';
import 'package:flutter/material.dart';
import 'package:bsa/components/background.dart';
import 'package:bsa/components/custominputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bsa/signUp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      size: size,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Padding(
                //welcome back text code below
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Welcome\nBack",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              //2 form fields code below
              SizedBox(height: 40),
              CustomInputField(
                label: 'Email',
                hint: "Enter your Email",
                size: size,
                prefixIcon: Icons.email_outlined,
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
              CustomInputField(
                label: 'Password',
                hint: "Enter your Password",
                size: size,
                prefixIcon: Icons.lock,
                obscure: true,
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
              //forgot password code below
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('Forgot Password?'),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ResetScreen())),
                  ),
                ],
              ),
              // GestureDetector(
              //   onPressed:
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 15.0),
              //     child: Text(
              //       "forgot password?",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 15,
              //         fontWeight: FontWeight.w300,
              //         decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              //),
              //code for or login with below here
              SizedBox(height: 15),
              Center(
                child: Text(
                  "OR continue with",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //code for google button
              SizedBox(
                height: 20,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: FlatButton(
                      minWidth: 150,
                      onPressed: () {
                        //code to sign in with google
                      },
                      padding: EdgeInsets.all(20),
                      color: Colors.blue,
                      child: Text('Google')),
                ),
              ),
              //sign in and the circular forward arrow button code below
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: FlatButton(
                      onPressed: () => _signin(_email, _password),
                      padding: EdgeInsets.all(20),
                      color: Color(0xFF0b132b),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              //sign up button in bottom left code below
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signin(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      //success
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
      // print(error.message);
    }
  }
}

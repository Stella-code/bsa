import 'package:bsa/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bsa/components/Background.dart';
import 'package:bsa/components/custominputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _username;
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
              //back button code below
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  CupertinoIcons.back,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              // Icon(
              //   Icons.dehaze,
              //   size: 35,
              //   color: Colors.white,
              // ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                //create acc text
                child: Text(
                  "Create\nAccount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 30),
              //form fields code below (2 fields)
              CustomInputField(
                label: 'E-mail',
                hint: "Enter your e-mail",
                size: size,
                prefixIcon: Icons.email_sharp,
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
              //signup with google code below
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
              SizedBox(height: 15),
              //Signup and forward arrow buttton code below
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: FlatButton(
                      onPressed: () => _signup(_email, _password),
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
              //code for the sign in button in bottom left
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Sign In",
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

  _signup(String _email, String _password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      //success
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
      // print(error.message);
    }
  }
}

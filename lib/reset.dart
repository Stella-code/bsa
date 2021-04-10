import 'package:bsa/home.dart';
import 'package:bsa/verify.dart';
import 'package:flutter/material.dart';
import 'package:bsa/components/background.dart';
import 'package:bsa/components/custominputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bsa/signUp.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
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
                  "Reset\nPassword",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              //1 form fields code below
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: FlatButton(
                      onPressed: () {
                        auth.sendPasswordResetEmail(email: _email);
                        Navigator.of(context).pop();
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}

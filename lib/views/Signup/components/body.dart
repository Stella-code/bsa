import 'package:bsa/components/text_field_container.dart';
import 'package:bsa/constants.dart';
import 'package:bsa/home.dart';
import 'package:bsa/locator.dart';
import 'package:bsa/view_controller/user_controller.dart';
import 'package:bsa/views/Login/login_screen.dart';
// import 'package:bsa/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bsa/views/Signup/components/background.dart';
import 'package:bsa/components/already_have_an_account_acheck.dart';
// import 'package:bsa/components/rounded_button.dart';
// import 'package:bsa/components/rounded_input_field.dart';
// import 'package:bsa/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "SIGNUP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            TextFieldContainer(
              child: TextField(
                //add code to change field color on input
                onChanged: (value) {},
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "Your Email",
                  border: InputBorder.none,
                ),
              ),
            ),
            // RoundedInputField(
            //   onChanged: (value) {},
            // ),
            TextFieldContainer(
              child: TextField(
                obscureText: true,
                onChanged: (value) {},
                cursorColor: kPrimaryColor,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  //can add a functional eye icon for password field later
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            // RoundedPasswordField(
            //   onChanged: (value) {},
            // ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () async {
                    //code for onPressed action
                    try {
                      CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      );
                      await locator
                          .get<UserController>()
                          .signUpWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => MapScreen()));
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      Fluttertoast.showToast(
                          msg: e.message, gravity: ToastGravity.TOP);
                    }
                  },
                  child: Text(
                    "SIGNUP",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "HelveticaNow"),
                  ),
                ),
              ),
            ),
            // RoundedButton(
            //   text: "SIGNUP",
            //   //below code is to create user on button press
            //   press: () {},
            // ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreenView();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bsa/components/text_field_container.dart';
import 'package:bsa/home.dart';
import 'package:bsa/repository/auth_repo.dart';
import 'package:bsa/view_controller/user_controller.dart';
import 'package:bsa/views/Login/components/or_divider.dart';
import 'package:bsa/views/Login/components/social_icon.dart';
import 'package:bsa/views/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bsa/views/Login/components/background.dart';
import 'package:bsa/components/already_have_an_account_acheck.dart';
// import 'package:bsa/components/rounded_button.dart';
// import 'package:bsa/components/rounded_input_field.dart';
// import 'package:bsa/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../locator.dart';
import '../../home_view.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var emailController =
        TextEditingController(text: "www.ultimatesupersaiyan@gmail.com");
    var passwordController = TextEditingController(text: "test12345");
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            // RoundedInputField(
            //   hintText: "Your Email",
            //   onChanged: (value) {},
            // ),
            TextFieldContainer(
              child: TextField(
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

            // RoundedPasswordField(
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

            // RoundedButton(
            //   text: "LOGIN",
            //   press: () {},
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
                      await locator
                          .get<UserController>()
                          .signInWithEmailAndPassword(
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
                    "SIGN IN",
                    style: TextStyle(
                        fontFamily: "HelveticaNow", color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpView();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {
                    //sign in with google
                    locator.get<AuthRepo>().signInWithGoogle();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

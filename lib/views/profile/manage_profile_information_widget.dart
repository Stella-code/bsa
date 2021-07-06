import 'package:bsa/components/text_field_container.dart';
import 'package:bsa/locator.dart';
import 'package:bsa/models/user_model.dart';
import 'package:bsa/view_controller/user_controller.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../home.dart';

class ManageProfileInformationWidget extends StatefulWidget {
  final UserModel currentUser;

  ManageProfileInformationWidget({this.currentUser});

  @override
  _ManageProfileInformationWidgetState createState() =>
      _ManageProfileInformationWidgetState();
}

class _ManageProfileInformationWidgetState
    extends State<ManageProfileInformationWidget> {
  bool showPassword = true;

  var _displayNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;

  @override
  void initState() {
    _displayNameController.text = widget.currentUser.displayName;
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFieldContainer(
            child: TextField(
              //add code to change field color on input
              onChanged: (value) {},
              cursorColor: kPrimaryColor,
              keyboardType: TextInputType.text,
              controller: _displayNameController,
              decoration: InputDecoration(
                labelText: "Username",
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                hintText: "Username",
                border: InputBorder.none,
              ),
            ),
          ),

          SizedBox(height: 20.0),

          Flexible(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Manage Password",
                    style: Theme.of(context).textTheme.headline4,
                  ),

                  TextFieldContainer(
                    child: TextField(
                      obscureText: showPassword,
                      onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password verification",
                        hintText: "Password",
                        errorText: checkCurrentPasswordValid
                            ? null
                            : "Incorrect password!",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        //can add a functional eye icon for password field later
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Password",
                  //     errorText: checkCurrentPasswordValid
                  //         ? null
                  //         : "Please double check your current password",
                  //   ),
                  //   controller: _passwordController,
                  // ),

                  Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.headline4,
                  ),

                  TextFieldContainer(
                    child: TextField(
                      obscureText: showPassword,
                      onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.text,
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        hintText: "New Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        //can add a functional eye icon for password field later
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // TextFormField(
                  //   decoration: InputDecoration(hintText: "New Password"),
                  //   controller: _newPasswordController,
                  //   obscureText: true,
                  // ),

                  TextFieldContainer(
                    child: TextFormField(
                      obscureText: showPassword,
                      onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.text,
                      controller: _repeatPasswordController,
                      validator: (value) {
                        return _newPasswordController.text == value
                            ? null
                            : "Please validate your entered password";
                      },
                      decoration: InputDecoration(
                        labelText: "Repeat Password",
                        hintText: "Repeat Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        //can add a functional eye icon for password field later
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Repeat Password",
                  //   ),
                  //   obscureText: true,
                  //   controller: _repeatPasswordController,
                  //   validator: (value) {
                  //     return _newPasswordController.text == value
                  //         ? null
                  //         : "Please validate your entered password";
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MapScreen()));
                },
                child: Text("CANCEL",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                        fontFamily: "DevantHorgen")),
              ),
              RaisedButton(
                onPressed: () async {
                  var userController = locator.get<UserController>();

                  if (widget.currentUser.displayName !=
                      _displayNameController.text) {
                    var displayName = _displayNameController.text;
                    userController.updateDisplayName(displayName);
                  }

                  checkCurrentPasswordValid = await userController
                      .validateCurrentPassword(_passwordController.text);

                  setState(() {});

                  if (_formKey.currentState.validate() &&
                      checkCurrentPasswordValid) {
                    userController
                        .updateUserPassword(_newPasswordController.text);
                    //below navigate to map screen later
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  }
                },
                color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "SAVE",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white,
                      fontFamily: "DevantHorgen"),
                ),
              ),
            ],
          ),

          // ignore: deprecated_member_use
          // RaisedButton(
          //   onPressed: () async {
          //     var userController = locator.get<UserController>();
          //
          //     if (widget.currentUser.displayName !=
          //         _displayNameController.text) {
          //       var displayName = _displayNameController.text;
          //       userController.updateDisplayName(displayName);
          //     }
          //
          //     checkCurrentPasswordValid = await userController
          //         .validateCurrentPassword(_passwordController.text);
          //
          //     setState(() {});
          //
          //     if (_formKey.currentState.validate() &&
          //         checkCurrentPasswordValid) {
          //       userController
          //           .updateUserPassword(_newPasswordController.text);
          //       //below navigate to map screen later
          //       Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(builder: (context) => MapScreen()));
          //     }
          //   },
          //   child: Text("Save Profile"),
          // ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:bsa/locator.dart';
import 'package:bsa/models/user_model.dart';
import 'package:bsa/view_controller/user_controller.dart';
import 'package:bsa/views/profile/avatar.dart';
import 'package:bsa/views/profile/manage_profile_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../home.dart';
import '../settings.dart';

class ProfileView extends StatefulWidget {
  final Function menuCallback;

  ProfileView({@required this.menuCallback});

  static String route = "profile-view";

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var avatarUrl;
  UserModel _currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    var picLink = _currentUser?.avatarUrl;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.green, fontFamily: "DevantHorgen"),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MapScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // GestureDetector(
                //   onTap: () {
                //     FocusScope.of(context).unfocus();
                //   },
                SizedBox(height: 10.0),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: "HelveticaNow"),
                ),
                Avatar(
                    avatarUrl: picLink == null
                        ? Icon(Icons.photo_camera)
                        : _currentUser?.avatarUrl,
                    // avatarUrl: _currentUser?.avatarUrl != null
                    //     ? _currentUser?.avatarUrl
                    //     : CircleAvatar(
                    //         radius: 50.0,
                    //         child: Icon(Icons.photo_camera_sharp),
                    //       ),
                    onTap: () async {
                      PickedFile selectedImage = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      File image = File(selectedImage.path);
                      print(image.path);
                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image);
                      setState(() {});
                    }),
                SizedBox(height: 10.0),
                Center(
                    child: Text(
                  "Hi ${_currentUser.displayName ?? 'nice to see you here.'}",
                  style: TextStyle(fontFamily: "DevantHorgen", fontSize: 26.0),
                )),
                SizedBox(height: 10.0),
                ManageProfileInformationWidget(
                  currentUser: _currentUser,
                ),
                SizedBox(height: 200.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

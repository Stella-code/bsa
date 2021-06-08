import 'dart:io';

import 'package:bsa/locator.dart';
import 'package:bsa/models/user_model.dart';
import 'package:bsa/view_controller/user_controller.dart';
import 'package:bsa/views/profile/avatar.dart';
import 'package:bsa/views/profile/manage_profile_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Avatar(
                      avatarUrl: picLink == null
                          ? CircleAvatar(
                              radius: 50.0,
                              child: Icon(Icons.photo_camera),
                            )
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
                  Text(
                      "Hi ${_currentUser.displayName ?? 'nice to see you here.'}"),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ManageProfileInformationWidget(
              currentUser: _currentUser,
            ),
          )
        ],
      ),
    );
  }
}

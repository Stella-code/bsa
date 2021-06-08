import 'dart:io';

import 'package:bsa/locator.dart';
import 'package:bsa/models/user_model.dart';
import 'package:bsa/repository/auth_repo.dart';
import 'package:bsa/repository/storage_repo.dart';
import 'package:flutter/material.dart';

class UserController {
  UserModel _currentUser;
  AuthRepo _authRepo = locator.get<AuthRepo>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(File image) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(image);
  }

  Future<String> getDownloadUrl() async {
    //can implement a if() below for new users pic fetching as there is none
    // if (getDownloadUrl() == null) {
    //   CircleAvatar(
    //     radius: 50.0,
    //     child: Icon(Icons.photo_camera_sharp),
    //   );
    // }
    return await _storageRepo.getUserProfileImage(currentUser.uid);
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);

    _currentUser.avatarUrl = await getDownloadUrl();
  }

  Future<void> signUpWithEmailAndPassword(
      {String email, String password}) async {
    _currentUser = await _authRepo.signUpWithEmailAndPassword(
        email: email, password: password);

    // _currentUser.avatarUrl = await getDownloadUrl();
  }

  void updateDisplayName(String displayName) {
    _currentUser.displayName = displayName;
    _authRepo.updateDisplayName(displayName);
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await _authRepo.validatePassword(password);
  }

  void updateUserPassword(String password) {
    _authRepo.updatePassword(password);
  }
}

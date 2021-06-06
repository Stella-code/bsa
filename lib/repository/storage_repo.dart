import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:bsa/locator.dart';
import 'package:bsa/models/user_model.dart';
import 'package:bsa/repository/auth_repo.dart';

class StorageRepo {
  FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: "gs://email-login-94234.appspot.com");
  AuthRepo _authRepo = locator.get<AuthRepo>();

  Future<String> uploadFile(File file) async {
    UserModel user = await _authRepo.getUser();
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = uploadTask.snapshot;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}

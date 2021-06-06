//this model is to get information relevant to us from firebase
//and discard unwanted data

class UserModel {
  String uid;
  String displayName;
  String avatarUrl;

  UserModel(this.uid, {this.displayName, this.avatarUrl});
}

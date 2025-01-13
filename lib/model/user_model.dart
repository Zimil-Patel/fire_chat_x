class UserModel {
  String? displayName, email, phoneNumber, photoURL;

  UserModel({this.displayName, this.email, this.phoneNumber, this.photoURL});

  factory UserModel.fromFireStore(Map map) => UserModel(
        displayName: map['displayName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        photoURL: map['photoURL'],
      );
}

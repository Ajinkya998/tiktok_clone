import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String profilePhoto;
  String uid;
  String name;

  UserModel({
    required this.email,
    required this.profilePhoto,
    required this.uid,
    required this.name,
  });

  Map<String, dynamic> toJson() =>
      {"email": email, "profilePhoto": profilePhoto, "uid": uid, "name": name};

  static UserModel fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['email'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid'],
        name: snapshot['name']);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String id;
  String uid;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String profilePhoto;
  String videoUrl;
  String thumbnail;

  VideoModel({
    required this.username,
    required this.id,
    required this.uid,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.profilePhoto,
    required this.videoUrl,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
        "uid": uid,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "profilePhoto": profilePhoto,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
      };

  static VideoModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return VideoModel(
      username: snapshot["username"],
      id: snapshot["id"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      commentCount: snapshot["commentCount"],
      shareCount: snapshot["shareCount"],
      songName: snapshot["songName"],
      caption: snapshot["caption"],
      profilePhoto: snapshot["profilePhoto"],
      videoUrl: snapshot["videoUrl"],
      thumbnail: snapshot["thumbnail"],
    );
  }
}

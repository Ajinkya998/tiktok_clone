import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _commentList = Rx<List<CommentModel>>([]);
  List<CommentModel> get commentList => _commentList.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _commentList.bindStream(firestore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<CommentModel> retValue = [];
        for (var element in query.docs) {
          retValue.add(CommentModel.fromSnap(element));
        }
        return retValue;
      },
    ));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection("users")
            .doc(authController.user.uid)
            .get();

        var allDocs = await firestore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .get();

        int len = allDocs.docs.length;

        CommentModel comment = CommentModel(
          DateTime.now(),
          username: (userDoc.data() as dynamic)['name'],
          comment: commentText.trim(),
          likes: [],
          profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          id: "Comment $len",
        );
        await firestore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .doc("Comment $len")
            .set(
              comment.toJson(),
            );

        DocumentSnapshot doc =
            await firestore.collection("videos").doc(_postId).get();
        await firestore.collection("videos").doc(_postId).update({
          "commentCount": (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar("Error While Commenting", e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    } else {
      firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}

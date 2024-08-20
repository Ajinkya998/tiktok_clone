import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/models/user_model.dart';

class SearchUserController extends GetxController {
  final Rx<List<UserModel>> _searchedUser = Rx<List<UserModel>>([]);
  List<UserModel> get searchedUser => _searchedUser.value;

  searchUser(String typedUser) async {
    _searchedUser.bindStream(firestore
        .collection("users")
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<UserModel> retVal = [];

        for (var element in query.docs) {
          retVal.add(UserModel.fromJson(element));
        }
        return retVal;
      },
    ));
  }
}

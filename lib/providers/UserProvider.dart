import 'package:evently_app1/model/user/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel? myUser;

  saveUser(UserModel? user) {
    myUser = user;
    notifyListeners();
  }

}
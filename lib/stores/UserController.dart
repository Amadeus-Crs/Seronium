import 'package:get/state_manager.dart';
import 'package:seronium_flutter/viewmodels/user.dart';

class Usercontroller extends GetxController{
  var user =User.fromJson({}).obs;
  updateUser(User newUser){
    user.value = newUser;
  }
}

import 'package:seronium_flutter/constants/index.dart';
import 'package:seronium_flutter/utils/ApiService.dart';
import 'package:seronium_flutter/viewmodels/user.dart';

Future<User> LoginAPI(Map<String,dynamic> data) async {
    User user = User.fromJson(
      await apiService.post(HTTPConstants.LOGIN,data)
    );
    return user;
}

Future<User> GetUserProfileAPI() async {
    User user = User.fromJson(
      await apiService.get(HTTPConstants.GET_USER_PROFILE,{})
    );
    return user;
}
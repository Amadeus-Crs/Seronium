import 'package:seronium_flutter/constants/index.dart';
import 'package:seronium_flutter/utils/ApiService.dart';
import 'package:seronium_flutter/viewmodels/user.dart';

Future<String?> LoginAPI(Map<String,dynamic> data) async {
    User.fromJson(
      await apiService.post(HTTPConstants.LOGIN,data)
    );
  }
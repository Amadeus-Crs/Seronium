import 'package:seronium_flutter/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance(){
    return SharedPreferences.getInstance();
  }
  String _token = "";
  Future<void> init()async{
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY)??"";

  }
  Future<void> setToken(String val)async{
    final prefs = await _getInstance();
    await prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }
  String getToken(){
    return _token;
  }
  Future<void> removeToken()async{
    final prefs = await _getInstance();
    await prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = TokenManager();
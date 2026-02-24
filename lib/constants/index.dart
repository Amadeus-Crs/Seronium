class GlobalConstants{
  static const String BASE_URL = "http://127.0.0.1:8080";
  static const int TIME_OUT=10;
  static const String SUCCESS_CODE="1";
}

class HTTPConstants{
  static const String LOGIN="/api/auth/login";
  static const String REGISTER="/api/auth/register";
  static const String CREATE_POSTS="/api/posts";
  static const String GET_POSTS="/api/posts/:id";
  static const String UPDATE_POSTS="/api/posts/:id";
  static const String DELETE_POSTS="/api/posts/:id";
  static const String GET_POST_LIST="/api/posts";
  static const String GET_POST_DETAIL="/api/posts/detail";
  static const String GET_USER_PROFILE="/api/user/profile";
}
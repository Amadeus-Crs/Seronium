import 'package:seronium_flutter/constants/index.dart';
import 'package:seronium_flutter/utils/ApiService.dart';
import 'package:seronium_flutter/viewmodels/post.dart';

CreatePost(Map<String, dynamic> data)async{
  await apiService.post(HTTPConstants.CREATE_POSTS,data);
}

GetPost(String postId)async{
  Post post =Post.fromJson(await apiService.get("${HTTPConstants.GET_POSTS}$postId",{}));
  return post;
}

GetPostListAPI({String? sort = "new"})async{
  await apiService.get(HTTPConstants.GET_POST_LIST,{'sort':sort});
}
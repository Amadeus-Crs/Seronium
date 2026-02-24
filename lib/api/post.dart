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

Future<List<Post>> GetPostListAPI({String? sort = "new",offset =0,limit = 10})async{
  return (await apiService.get(HTTPConstants.GET_POST_LIST,{'sort':sort,'offset':offset,'limit':limit}) as List).map((item){
    return Post.fromJson(item);
  }).toList();
}
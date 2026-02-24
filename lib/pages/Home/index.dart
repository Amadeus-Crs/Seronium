import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';

import 'package:seronium_flutter/api/login.dart';
import 'package:seronium_flutter/api/post.dart';
import 'package:seronium_flutter/pages/Home/postcard.dart';
import 'package:seronium_flutter/stores/TokenManager.dart';
import 'package:seronium_flutter/stores/UserController.dart';
import 'package:seronium_flutter/viewmodels/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPosts();
    _initUser();
  }
  final Usercontroller _userController = Get.put(Usercontroller());
  _initUser()async{
    tokenManager.init();
    if(tokenManager.getToken().isNotEmpty){
      _userController.updateUser(await GetUserProfileAPI());
    }
  }
  Future<void> _loadPosts()async{
    setState(() => loading = true);
    try {
      final data = await GetPostListAPI(sort: "hot");
      posts = data.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      
    }
    setState(() => loading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seronium'), actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ]),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadPosts,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: posts.length,
                itemBuilder: (context, index) => PostCard(post: posts[index]),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create'),
        icon: const Icon(Icons.edit),
        label: const Text('发帖'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';

import 'package:seronium_flutter/api/user.dart';
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
//   List<Post> posts = [];
//   bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initUser();
    // _loadPosts();
  }
  final Usercontroller _userController = Get.put(Usercontroller());
  _initUser() async {
  try {
    tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      final user = await GetUserProfileAPI();
      _userController.updateUser(user);
    }
  } catch (e) {
    debugPrint("获取用户资料失败: $e");
  }
}

// Future<void> _loadPosts() async {
//     setState(() => loading = true);
//     try {
//       final posts = await GetPostListAPI(sort: "hot");
//     } catch (e) {
//       // ignore
//     }
//     setState(() => loading = false);
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seronium'), actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ]),
      // body: loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : RefreshIndicator(
      //         onRefresh: _loadPosts,
      //         child: ListView.builder(
      //           padding: const EdgeInsets.all(16),
      //           itemCount: posts.length,
      //           itemBuilder: (context, index) => PostCard(post: posts[index]),
      //         ),
      //       ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create'),
        icon: const Icon(Icons.edit),
        label: const Text('发帖'),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Home Screen"));
//   }
// }
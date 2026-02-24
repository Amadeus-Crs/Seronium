import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:seronium_flutter/stores/UserController.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Usercontroller _userController = Get.put(Usercontroller());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Obx( (){
      if(_userController.user.value.username.isEmpty){
        return Center(child:TextButton(onPressed: (){
          context.go('/login');
        }, child: Text("Login")));
      }else{
        return Scaffold(
      appBar: AppBar(title: const Text('个人中心'), actions: [
        IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
      ]),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(radius: 50, backgroundColor: Colors.blue.shade100),
                        const SizedBox(height: 16),
                        Text(_userController.user.value.username, style: Theme.of(context).textTheme.headlineMedium),
                        Text(_userController.user.value.bio, style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  Text("我的帖子", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  // ...myPosts.map((post) => PostCard(post: post)),

                  const SizedBox(height: 40),

                  Text("我的收藏", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const Text("暂无收藏", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
    );
      }
    }
      );
    }
  }

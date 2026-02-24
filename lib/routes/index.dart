import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seronium_flutter/pages/Home/index.dart';
import 'package:seronium_flutter/pages/Login/index.dart';
import 'package:seronium_flutter/pages/Post/create.dart';
import 'package:seronium_flutter/pages/Post/detail.dart';
import 'package:seronium_flutter/pages/Profile/index.dart';


final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/login', builder: (_, __) =>  LoginScreen()),
    // GoRoute(path:'/joke', builder: (_, __) => const JokeScreen()),
    ShellRoute(
      builder: (context, state, child) => HomeShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/create', builder: (_, __) => const CreatePostScreen()),
        GoRoute(path: '/post/:id', builder: (_, state) => PostDetailScreen(postId: state.pathParameters['id']!)),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      ],
    ),
  ],
);

class HomeShell extends StatelessWidget {
  final Widget child;
  const HomeShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: _getSelectedIndex(context),
              onDestinationSelected: (index) => _onNavTap(context, index),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text('首页')),
                NavigationRailDestination(icon: Icon(Icons.add), label: Text('发布')),
                NavigationRailDestination(icon: Icon(Icons.person), label: Text('我的')),
              ],
            ),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: isWide ? null : _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(context),
      onTap: (index) => _onNavTap(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: '发布'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
      ],
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.contains('/create')) return 1;
    if (location.contains('/profile')) return 2;
    return 0;
  }

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) context.go('/home');
    if (index == 1) context.go('/create');
    if (index == 2) context.go('/profile');
}
}
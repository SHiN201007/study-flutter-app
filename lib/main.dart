import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/core/followlist_type.dart';
import 'package:study_app/screens/followlist/followlist_screen.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/profile/profile_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _goRouter);
  }
}

enum AppRoute {
  home(path: '/', name: 'home'),
  followlist(path: '/followlist/:type', name: 'followlist'),
  profile(path: '/profile/:userId', name: 'profile');

  const AppRoute({required this.path, required this.name});

  final String path;
  final String name;
}

final GoRouter _goRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoute.followlist.path,
      name: AppRoute.followlist.name,
      builder: (context, state) => FollowlistScreen(
        followListType: FollowListType.fromName(state.pathParameters['type']),
      ),
    ),
    GoRoute(
      path: AppRoute.profile.path,
      name: AppRoute.profile.name,
      builder: (context, state) => ProfileScreen(
        userId: state.pathParameters['userId'] ?? 'unknown',
      ),
    ),
  ],
);

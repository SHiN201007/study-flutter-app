import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_app/core/followlist_type.dart';
import 'package:study_app/main.dart';
import 'package:study_app/ui/app_header.dart';
import 'package:study_app/screens/home/components/home_profile_section.dart';
import 'package:study_app/screens/home/components/post_grid_section.dart';
import 'package:study_app/screens/home/components/post_segment.dart';
import 'package:study_app/ui/snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onTapFollowing(BuildContext context) {
    context.pushNamed(
      AppRoute.followlist.name,
      pathParameters: {'type': FollowListType.following.name},
    );
  }

  void _onTapFollowers(BuildContext context) {
    context.pushNamed(
      AppRoute.followlist.name,
      pathParameters: {'type': FollowListType.followers.name},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.dismissAppSnackbar(),
        child: Column(
          children: [
            AppHeader(
              title: 'Home Header',
              onMenuPressed: () =>
                  context.showAppSnackbar('Menu button pressed'),
            ),
            const SizedBox(height: 12),
            HomeProfileSection(
              onTapFollowing: () => _onTapFollowing(context),
              onTapFollowers: () => _onTapFollowers(context),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: PostSegment(selected: 'all'),
            ),
            Expanded(child: PostGridSection()),
          ],
        ),
      ),
    );
  }
}

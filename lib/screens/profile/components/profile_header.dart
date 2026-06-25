

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/features/user/user_provider.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
          ),
        ),
        SizedBox(height: 8),
        Text('@${currentUser.handle}'),
      ],
    );
  }
}
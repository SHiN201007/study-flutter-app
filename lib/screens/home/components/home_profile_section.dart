import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/features/user/user_provider.dart';

class HomeProfileSection extends StatelessWidget {
  const HomeProfileSection({
    super.key,
    this.onTapFollowing,
    this.onTapFollowers,
  });

  final VoidCallback? onTapFollowing;
  final VoidCallback? onTapFollowers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeProfileIcon(),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                HomeProfileItem(),
                const SizedBox(height: 4),
                HomeProfileFollowInfo(
                  onTapFollowing: onTapFollowing,
                  onTapFollowers: onTapFollowers,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeProfileIcon extends StatelessWidget {
  const HomeProfileIcon({super.key});
  final double _profileImageSize = 64;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _profileImageSize,
      height: _profileImageSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlueAccent, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(_profileImageSize / 2),
        ),
      ),
    );
  }
}

class HomeProfileItem extends ConsumerWidget {
  const HomeProfileItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                '@${user.handle}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        HomeProfileFollowButton(),
      ],
    );
  }
}

class HomeProfileFollowButton extends ConsumerWidget {
  const HomeProfileFollowButton({super.key});

  void _onTapFollow(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).toggleFollow();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return ElevatedButton(
      onPressed: () => _onTapFollow(context, ref),
      style: ElevatedButton.styleFrom(
        backgroundColor: user.isFollowing ? Colors.grey : Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
      child: Text(
        user.isFollowing ? 'Following' : 'Follow',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class HomeProfileFollowInfo extends ConsumerWidget {
  const HomeProfileFollowInfo({
    super.key,
    this.onTapFollowing,
    this.onTapFollowers,
  });

  final VoidCallback? onTapFollowing;
  final VoidCallback? onTapFollowers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: onTapFollowing,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            user.followingCount.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        Text('Following', style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onTapFollowers,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            user.followersCount.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        const Text('Followers', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

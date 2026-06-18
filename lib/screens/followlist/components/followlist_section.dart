import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/core/followlist_type.dart';
import 'package:study_app/models/user.dart';
import 'package:study_app/features/followlist/followlist_provider.dart';

class FollowlistSection extends ConsumerWidget {
  const FollowlistSection({super.key, required this.followListType});

  final FollowListType followListType;

  /// 引っ張って更新したときに呼ばれる。完了する Future を返すと、
  /// その完了までインジケーターが回り続ける。
  Future<void> _onRefresh(WidgetRef ref) async {
    ref.invalidate(followlistProvider(followListType));
    await ref.read(followlistProvider(followListType).future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFollowlist = ref.watch(followlistProvider(followListType));
    return asyncFollowlist.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
      data: (items) => RefreshIndicator(
        onRefresh: () => _onRefresh(ref),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return FollowlistItem(index: index, user: items[index]);
          },
        ),
      ),
    );
  }
}

class FollowlistItem extends StatelessWidget {
  const FollowlistItem({super.key, required this.index, required this.user});

  final int index;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FollowlistProfileIcon(),
          const SizedBox(width: 8),
          FollowlistProfileItem(user: user),
        ],
      ),
    );
  }
}

class FollowlistProfileIcon extends StatelessWidget {
  const FollowlistProfileIcon({super.key});
  final double _profileImageSize = 54;

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

class FollowlistProfileItem extends StatelessWidget {
  const FollowlistProfileItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user.name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Text(
          '@${user.handle}',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

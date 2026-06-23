import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/core/followlist_type.dart';
import 'package:study_app/features/user/user_provider.dart';
import 'package:study_app/models/user.dart';

final followlistProvider =
    AsyncNotifierProvider.family<
      FollowlistNotifier,
      List<User>,
      FollowListType
    >(FollowlistNotifier.new);

class FollowlistNotifier extends AsyncNotifier<List<User>> {
  FollowlistNotifier(this.followListType);

  final FollowListType followListType;

  @override
  Future<List<User>> build() async {
    final users = await _fetchDummyData();
    return switch (followListType) {
      FollowListType.following =>
        users.where((user) => user.isFollowing).toList(),
      FollowListType.followers =>
        users.where((user) => !user.isFollowing).toList(),
    };  
  }

  Future<List<User>> _fetchDummyData() async {
    final users = await ref.watch(usersProvider.future);
    return users;
  }
}

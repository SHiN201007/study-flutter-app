import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/core/followlist_type.dart';
import 'package:study_app/features/user/user_provider.dart';
import 'package:study_app/models/user.dart';

part 'followlist_provider.g.dart';

@riverpod
Future<List<User>> followlist(Ref ref, FollowListType followListType) async {
  final users = await ref.watch(usersProvider.future);
  return switch (followListType) {
    FollowListType.following => users.where((user) => user.isFollowing).toList(),
    FollowListType.followers => users.where((user) => !user.isFollowing).toList(),
  };
}
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/data/user/user_repository.dart';
import 'package:study_app/models/user.dart';

part 'user_provider.g.dart';

@riverpod
Future<Map<String, User>> usersById(Ref ref) async {
  final users = await ref.watch(userRepositoryProvider).getUsers();
  return { for (final u in users) u.id: u };
}

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  User build() {
    return ref.watch(userRepositoryProvider).getCurrentUser();
  }

  void toggleFollow() {
    final wasFollowing = state.isFollowing;
    state = state.copyWith(
      isFollowing: !wasFollowing,
      followersCount: wasFollowing
          ? state.followersCount - 1
          : state.followersCount + 1,
    );
  }
}

@riverpod
Future<List<User>> users(Ref ref) async {
  return await ref.watch(userRepositoryProvider).getUsers();
}
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

  Future<void> updateProfile(String name, String bio) async {
    final oldState = state;
    try {
      final newState = state.copyWith(name: name.trim(), bio: bio.trim());
      state = newState;
      await ref.read(userRepositoryProvider).updateProfile(name, bio);
    }catch (e) {
      state = oldState;
      rethrow;
    }
  }

  Future<void> updateProfileImage(String path) async {
    final oldState = state;
    try {
      final newState = state.copyWith(localImagePath: path);
      state = newState;
      await ref.read(userRepositoryProvider).updateProfileImage(path);
    }catch (e) {
      state = oldState;
      rethrow;
    }
  }
}

@riverpod
Future<List<User>> users(Ref ref) async {
  return await ref.watch(userRepositoryProvider).getUsers();
}
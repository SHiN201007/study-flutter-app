import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/models/user.dart';

final userProvider = NotifierProvider<UserNotifier, User>(UserNotifier.new);

class UserNotifier extends Notifier<User> {
  @override
  User build() {
    return const User(
      id: '1',
      handle: 'john_smith',
      name: 'John Smith',
      followersCount: 100,
      followingCount: 100,
      isFollowing: false,
    );
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

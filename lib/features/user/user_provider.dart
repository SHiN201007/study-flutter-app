import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/models/user.dart';

final userProvider = NotifierProvider<UserNotifier, User>(UserNotifier.new);
final usersProvider = AsyncNotifierProvider<UsersNotifier,List<User>>(UsersNotifier.new);
final usersByIdProvider = FutureProvider<Map<String, User>>((ref) async {
  final users = await ref.watch(usersProvider.future);
  return { for (final u in users) u.id: u };
});


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


class UsersNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() async {
    return _fetchDummyUsers();
  }

  Future<List<User>> _fetchDummyUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      User(
        id: '1',
        handle: 'john_smith',
        name: 'John Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: false,
      ),
      User(
        id: '2',
        handle: 'jane_smith',
        name: 'Jane Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: true,
      ),
      User(
        id: '3',
        handle: 'jim_smith',
        name: 'Jim Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: false,
      ),
      User(
        id: '4',
        handle: 'jill_smith',
        name: 'Jill Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: true,
      ),
      User(
        id: '5',
        handle: 'jack_smith',
        name: 'Jack Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: false,
      ),
      User(
        id: '6',
        handle: 'jill_smith',
        name: 'Jill Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: true,
      ),
      User(
        id: '7',
        handle: 'jack_smith',
        name: 'Jack Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: false,
      ),
      User(
        id: '8',
        handle: 'jill_smith',
        name: 'Jill Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: true,
      ),
      User(
        id: '9',
        handle: 'jack_smith',
        name: 'Jack Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: false,
      ),
      User(
        id: '10',
        handle: 'jill_smith',
        name: 'Jill Smith',
        followersCount: 100,
        followingCount: 100,
        isFollowing: true,
      ),
    ];
  }
}
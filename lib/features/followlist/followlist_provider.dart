import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/core/followlist_type.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    final users = [
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
    return users;
  }
}

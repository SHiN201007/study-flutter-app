

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/models/user.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(Ref ref) => UserRepository();

class UserRepository {

  User getCurrentUser() {
    return const User(
      id: '1',
      handle: 'john_smith',
      name: 'John Smith',
      followersCount: 100,
      followingCount: 100,
      isFollowing: false,
      bio: 'I am a software engineer',
    );
  }

  Future<List<User>> getUsers() async {
    return _fetchDummyUsers();
  }

  Future<void> updateProfile(String name, String bio) async {
    await Future.delayed(const Duration(seconds: 2));
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

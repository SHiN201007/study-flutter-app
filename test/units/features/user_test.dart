

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/data/user/user_repository.dart';
import 'package:study_app/features/user/user_provider.dart';
import 'package:study_app/models/user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {

  late MockUserRepository mockRepo;

  setUp(() {
    mockRepo = MockUserRepository();
  });

  group('toggle follow', () {
    test('not following → following = increment followers count', () {
      // 初期値: フォローしていない状態にする
      when(() => mockRepo.getCurrentUser())
        .thenReturn(buildUser(isFollowing: false));

      final container = buildContainer(mockRepo: mockRepo);

      final currentUser = container.read(currentUserProvider);
      expect(currentUser.isFollowing, false);
      expect(currentUser.followersCount, 100);

      container.read(currentUserProvider.notifier).toggleFollow();

      final toggledCurrentUser = container.read(currentUserProvider);
      expect(toggledCurrentUser.isFollowing, true);
      expect(toggledCurrentUser.followersCount, 101);
    });

    test('following → not following = decrement followers count', () {
      // 初期値: フォロー中の状態にする
      when(() => mockRepo.getCurrentUser())
          .thenReturn(buildUser(isFollowing: true));

      final container = buildContainer(mockRepo: mockRepo);

      final currentUser = container.read(currentUserProvider);
      expect(currentUser.isFollowing, true);
      expect(currentUser.followersCount, 100);

      container.read(currentUserProvider.notifier).toggleFollow();

      final toggledCurrentUser = container.read(currentUserProvider);
      expect(toggledCurrentUser.isFollowing, false);
      expect(toggledCurrentUser.followersCount, 99);
    });
  });

}

// -- Helpers --

User buildUser({bool isFollowing = false}) => User(
    id: '1',
    handle: 'john_doe',
    name: 'John Doe',
    followersCount: 100,
    followingCount: 100,
    isFollowing: isFollowing,
  );

ProviderContainer buildContainer({required MockUserRepository mockRepo}) {
  final container = ProviderContainer(
    overrides: [  
      userRepositoryProvider.overrideWith((_) => mockRepo),
    ],
  );
  addTearDown(container.dispose);
  return container;
}
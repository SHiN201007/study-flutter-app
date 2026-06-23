

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/data/posts/posts_repository.dart';
import 'package:study_app/data/user/user_repository.dart';
import 'package:study_app/features/feed/feed_provider.dart';
import 'package:study_app/models/post.dart';
import 'package:study_app/models/user.dart';

class MockPostRepository extends Mock implements PostsRepository {}
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockPostRepository mockPostRepo;
  late MockUserRepository mockUserRepo;

  setUp(() {
    mockPostRepo = MockPostRepository();
    mockUserRepo = MockUserRepository();
  });

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        postsRepositoryProvider.overrideWith((_) => mockPostRepo),
        userRepositoryProvider.overrideWith((_) => mockUserRepo),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  User buildUser(String id) => User(
    id: id,
    handle: 'john_doe',
    name: 'John Doe',
    followersCount: 100,
    followingCount: 100,
    isFollowing: false,
  );

  Post buildPost(String id, String authorId) => Post(
    id: id,
    authorId: authorId,
    imageUrl: 'https://example.com/image.jpg'
  );

  test('accept combined post with author', () async {
    when(() => mockUserRepo.getUsers()).thenAnswer((_) async => [
      buildUser('user_1'),
      buildUser('user_2'),
      buildUser('user_3')
    ]);
    when(() => mockPostRepo.getPosts()).thenAnswer((_) async => [
      buildPost('post_1', 'user_1'),
      buildPost('post_2', 'user_1'),
      buildPost('post_3', 'user_2'),
      buildPost('post_4', 'user_3'),
    ]);

    final container = buildContainer();
    final feeds = await container.read(feedProvider('user_1').future);

    expect(feeds.length, 2);
    expect(feeds[0].post.id, 'post_1');
    expect(feeds[0].author.id, 'user_1');
    expect(feeds[1].post.id, 'post_2');
    expect(feeds[1].author.id, 'user_1');
  },);

  // test('not found author = throw exception', () {

  // });
}
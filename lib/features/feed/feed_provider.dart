import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:study_app/features/post/post_provider.dart';
import 'package:study_app/features/post/post_with_author.dart';
import 'package:study_app/features/user/user_provider.dart';

part 'feed_provider.g.dart';

@riverpod
Future<List<PostWithAuthor>> feed(Ref ref, String authorId) async {
  final postsFuture = ref.watch(postsProvider(authorId).future);
  final usersFuture = ref.watch(usersByIdProvider.future);

  final (posts, users) = await (postsFuture, usersFuture).wait;

  return posts.map((post) {
    final author = users[post.authorId];
    if (author == null) {
      throw Exception('Author not found');
    }
    return PostWithAuthor(post: post, author: author);
  }).toList();
}
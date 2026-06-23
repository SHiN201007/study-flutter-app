import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/features/post/post_provider.dart';
import 'package:study_app/features/post/post_with_author.dart';
import 'package:study_app/features/user/user_provider.dart';

final feedProvider =
    AsyncNotifierProvider.family<FeedNotifier, List<PostWithAuthor>, String>(
      FeedNotifier.new,
    );

class FeedNotifier extends AsyncNotifier<List<PostWithAuthor>> {
  FeedNotifier(this.authorId);

  final String authorId;

  @override
  Future<List<PostWithAuthor>> build() async {
    return _fetchDummyFeeds();
  }


  Future<List<PostWithAuthor>> _fetchDummyFeeds() async {
    final posts = await ref.watch(postProvider(authorId).future);
    final users = await ref.watch(usersByIdProvider.future);
    return posts.map((post) {
      final author = users[post.authorId];
      if (author == null) {
        throw Exception('Author not found');
      }
      return PostWithAuthor(post: post, author: author);
    }).toList();
  }
}

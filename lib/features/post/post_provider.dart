import 'package:study_app/data/posts/posts_repository.dart';
import 'package:study_app/models/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
Future<List<Post>> posts(Ref ref, String authorId) async {
  final posts = await ref.watch(postsRepositoryProvider).getPosts();
  return posts.where((post) => post.authorId == authorId).toList();
}
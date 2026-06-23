import 'package:study_app/models/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
Future<List<Post>> posts(Ref ref, String authorId) async {
  final posts = await _fetchDummyPosts();
  return posts.where((post) => post.authorId == authorId).toList();
}

Future<List<Post>> _fetchDummyPosts() async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    Post(id: '1', authorId: '1', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '2', authorId: '2', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '3', authorId: '1', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '4', authorId: '2', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '5', authorId: '1', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '6', authorId: '2', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '7', authorId: '2', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '8', authorId: '1', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '9', authorId: '2', imageUrl: 'https://via.placeholder.com/150'),
    Post(id: '10', authorId: '1', imageUrl: 'https://via.placeholder.com/150'),
  ];
}
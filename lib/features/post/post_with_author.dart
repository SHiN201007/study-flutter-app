

import 'package:study_app/models/post.dart';
import 'package:study_app/models/user.dart';

class PostWithAuthor {
  final Post post;
  final User author;

  PostWithAuthor({required this.post, required this.author});
}
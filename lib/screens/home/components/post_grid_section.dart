import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/features/feed/feed_provider.dart';
import 'package:study_app/features/post/post_with_author.dart';
import 'package:study_app/features/user/user_provider.dart';

class PostGridSection extends ConsumerWidget {
  const PostGridSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider.select((user) => user.id));
    final feedAsync = ref.watch(feedProvider(userId));

    return feedAsync.when(
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (feed) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: feed.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) =>
            _PostGridItem(index: index, feedItem: feed[index]),
      )
    );
  }
}

class _PostGridItem extends StatelessWidget {
  const _PostGridItem({required this.index, required this.feedItem});

  final int index;
  final PostWithAuthor feedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index.isEven ? Colors.greenAccent : Colors.lightGreenAccent,
      child: SizedBox.square(
        dimension: double.infinity,
        child: Stack(
          children: [
            Center(child: Text('Post ${feedItem.post.id}')),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_outlined)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('@${feedItem.author.handle}'),
                  ],
                )
              ],
            ),
          ],
        )
      ) 
    );
  }
}

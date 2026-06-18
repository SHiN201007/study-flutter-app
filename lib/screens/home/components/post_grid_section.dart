import 'package:flutter/material.dart';

class PostGridSection extends StatelessWidget {
  const PostGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 1,
      ),
      itemCount: 33,
      padding: .zero,
      itemBuilder: (context, index) => Container(
        color: Colors.red,
        child: _PostGridItem(index: index),
      ),
    );
  }
}

class _PostGridItem extends StatelessWidget {
  const _PostGridItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index.isEven ? Colors.greenAccent : Colors.lightGreenAccent,
      child: Center(child: Text('Post $index')),
    );
  }
}

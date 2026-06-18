import 'package:flutter/material.dart';
import 'package:study_app/core/followlist_type.dart';
import 'package:study_app/screens/followlist/components/followlist_section.dart';

class FollowlistScreen extends StatefulWidget {
  const FollowlistScreen({super.key, required this.followListType});

  final FollowListType followListType;

  @override
  State<FollowlistScreen> createState() => _FollowlistScreenState();
}

class _FollowlistScreenState extends State<FollowlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.followListType.name),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: FollowlistSection(followListType: widget.followListType),
    );
  }
}

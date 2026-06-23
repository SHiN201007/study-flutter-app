import 'package:flutter_test/flutter_test.dart';
import 'package:study_app/core/followlist_type.dart';

void main() {
  test('followlist type: followers の場合、followers を返す', () {
    const input = 'followers';
    final result = FollowListType.fromName(input);
    expect(result, FollowListType.followers);
  });

  test('followlist type: following の場合、following を返す', () {
    const input = 'following';
    final result = FollowListType.fromName(input);
    expect(result, FollowListType.following);
  });

  test('followlist type: unknown の場合、following を返す', () {
    const input = 'unknown';
    final result = FollowListType.fromName(input);
    expect(result, FollowListType.following);
  });
}
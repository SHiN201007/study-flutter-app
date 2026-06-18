enum FollowListType {
  following,
  followers;

  /// 文字列(主にルートのパスパラメータ)から対応する値を返す。
  /// 不明な値の場合は [following] にフォールバックする。
  static FollowListType fromName(String? name) =>
      values.firstWhere((type) => type.name == name, orElse: () => following);
}

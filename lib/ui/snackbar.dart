import 'package:flutter/material.dart';

/// アプリ共通 SnackBar のスタイル定数。
const double _snackbarRadius = 10;
const EdgeInsets _snackbarMargin = EdgeInsets.only(
  left: 23,
  right: 23,
  bottom: 23,
);
const Duration _snackbarDuration = Duration(seconds: 4);

/// 表示中の SnackBar を制御する操作ハンドル。
///
/// [BuildContext.showAppSnackbar] の戻り値として受け取る。
class AppSnackbarHandle {
  const AppSnackbarHandle(this._controller);

  final ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _controller;

  /// この SnackBar を閉じる。
  void dismiss() => _controller.close();

  /// この SnackBar が閉じられたときに完了する Future。
  Future<SnackBarClosedReason> get closed => _controller.closed;
}

/// SnackBar 表示まわりのユーティリティ拡張。
extension AppSnackbarMessenger on BuildContext {
  /// アプリ共通スタイルの SnackBar を表示し、操作ハンドルを返す。
  ///
  /// 既存の SnackBar は閉じてから表示するため、重なって溜まらない。
  AppSnackbarHandle showAppSnackbar(
    String message, {
    Duration duration = _snackbarDuration,
  }) {
    final messenger = ScaffoldMessenger.of(this)..hideCurrentSnackBar();
    final controller = messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        margin: _snackbarMargin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_snackbarRadius),
        ),
      ),
    );
    return AppSnackbarHandle(controller);
  }

  /// 表示中の SnackBar があれば閉じる。
  void dismissAppSnackbar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();
}

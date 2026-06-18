import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.onMenuPressed});

  /// ステータスバーを除いたヘッダー本体の高さ。
  static const double _contentHeight = 64;

  final String title;
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      height: _contentHeight + topPadding,
      padding: EdgeInsets.only(top: topPadding),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PostSegment extends StatefulWidget {
  const PostSegment({
    super.key,
    required this.selected,
    this.indicatorColor = Colors.black,
    this.indicatorWeight = 2,
    this.selectedForegroundColor = Colors.black,
    this.unselectedForegroundColor = Colors.grey,
  });

  final String selected;

  /// 選択中セグメントの下線(インジケーター)の色。
  final Color indicatorColor;

  /// 選択中セグメントの下線の太さ。
  final double indicatorWeight;

  /// 選択中セグメントの文字色。
  final Color selectedForegroundColor;

  /// 未選択セグメントの文字色。
  final Color unselectedForegroundColor;

  @override
  State<PostSegment> createState() => _PostSegmentState();
}

class _PostSegmentState extends State<PostSegment> {
  final List<String> _segments = ['all', 'video', 'image'];
  String _selected = "all";

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      selected: {_selected},
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStateProperty.all(BorderSide.none),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
      ),
      segments: _segments.map((e) {
        final isSelected = e == _selected;
        return ButtonSegment(
          value: e,
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? widget.indicatorColor
                      : Colors.transparent,
                  width: widget.indicatorWeight,
                ),
              ),
            ),
            child: Text(
              e,
              style: TextStyle(
                color: isSelected
                    ? widget.selectedForegroundColor
                    : widget.unselectedForegroundColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
      onSelectionChanged: (value) => setState(() => _selected = value.first),
    );
  }
}

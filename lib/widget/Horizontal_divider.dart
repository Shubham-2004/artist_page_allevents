import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final double height;
  final Color color;
  final EdgeInsets margin;
  final double indent;
  final double endIndent;

  const HorizontalDivider({
    Key? key,
    this.height = 1.0,
    this.color = const Color.fromARGB(255, 234, 230, 230),
    this.margin = EdgeInsets.zero,
    this.indent = 0.0,
    this.endIndent = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      margin: margin,
    );
  }
}

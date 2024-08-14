import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imagePath;
  final bool showOverlay;
  final String overlayText;
  final BorderSide? borderTop;
  final BorderSide? borderRight;
  final BorderSide? borderBottom;
  final BorderSide? borderLeft;

  const ImageTile({
    Key? key,
    required this.imagePath,
    this.showOverlay = false,
    this.overlayText = '',
    this.borderTop,
    this.borderRight,
    this.borderBottom,
    this.borderLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: borderTop ?? BorderSide.none,
              right: borderRight ?? BorderSide.none,
              bottom: borderBottom ?? BorderSide.none,
              left: borderLeft ?? BorderSide.none,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        if (showOverlay)
          Container(
            color: Colors.black45,
            child: Center(
              child: Text(
                overlayText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

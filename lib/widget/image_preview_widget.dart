import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final List<String> imagePaths;
  final ValueChanged<int> onTap;
  final int selectedIndex;

  const ImagePreviewWidget({
    Key? key,
    required this.imagePaths,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedIndex == index ? Colors.blue : Colors.white,
                  width: 2.0,
                ),
              ),
              child: Image.asset(
                imagePaths[index],
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

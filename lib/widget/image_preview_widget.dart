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
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0, left: 8, right: 8),
      child: Container(
        height: 50.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.white,
                    width: 2.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 0),
                          ),
                        ]
                      : [],
                ),
                child: Image.asset(
                  imagePaths[index],
                  width: 36.0,
                  height: 36.0,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

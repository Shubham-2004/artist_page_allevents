import 'package:flutter/material.dart';

class PhotoDetailPage extends StatelessWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const PhotoDetailPage({
    Key? key,
    required this.imagePaths,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black, // Optional: to match the background
        title: const Text('Photo Detail'),
      ),
      body: PageView.builder(
        itemCount: imagePaths.length,
        controller: PageController(initialPage: initialIndex),
        itemBuilder: (context, index) {
          return Hero(
            tag: imagePaths[
                index], // Ensure this tag matches the Hero widget in the grid
            child: Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(8.0), // Maintain the border radius
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double
                      .infinity, // Ensure the image fills the available space
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

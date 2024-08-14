// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class PhotoGrid extends StatelessWidget {
//   const PhotoGrid({Key? key}) : super(key: key);

//   Future<ui.Image> _loadImage(String assetPath) async {
//     final Completer<ui.Image> completer = Completer<ui.Image>();
//     final ImageStream stream =
//         AssetImage(assetPath).resolve(ImageConfiguration.empty);
//     final ImageStreamListener listener = ImageStreamListener(
//       (ImageInfo info, bool _) => completer.complete(info.image),
//     );
//     stream.addListener(listener);
//     final ui.Image image = await completer.future;
//     stream.removeListener(listener);
//     return image;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<String> imagePaths = [
//       'assets/images/image1.jpeg',
//       'assets/images/image2.jpeg',
//       'assets/images/image3.jpeg',
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'More photos from shows',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         FutureBuilder<List<StaggeredGridTile>>(
//           future: _createStaggeredTiles(imagePaths),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return const Center(child: Text('Failed to load images'));
//             } else {
//               return StaggeredGrid.count(
//                 crossAxisCount: 3, // Adjust based on your design needs
//                 mainAxisSpacing: 4,
//                 crossAxisSpacing: 4,
//                 children: snapshot.data!,
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Future<List<StaggeredGridTile>> _createStaggeredTiles(
//       List<String> imagePaths) async {
//     List<StaggeredGridTile> tiles = [];

//     for (String path in imagePaths) {
//       ui.Image image = await _loadImage(path);

//       final double aspectRatio = image.width / image.height;
//       final int crossAxisCellCount = (aspectRatio > 1.0) ? 2 : 1;
//       final int mainAxisCellCount = (aspectRatio > 1.0) ? 2 : 1;

//       tiles.add(
//         StaggeredGridTile.count(
//           crossAxisCellCount: crossAxisCellCount,
//           mainAxisCellCount: mainAxisCellCount,
//           child: ImageTile(imagePath: path),
//         ),
//       );
//     }

//     return tiles;
//   }
// }

// class ImageTile extends StatelessWidget {
//   final String imagePath;

//   const ImageTile({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(8.0),
//       child: Image.asset(
//         imagePath,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/images/image5.jpeg',
      'assets/images/image2.jpeg',
      'assets/images/image3.jpeg',
      'assets/images/image4.jpeg',
      'assets/images/image6.jpeg', // Additional images
      'assets/images/image7.jpeg',
      'assets/images/image7.jpeg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'More photos from shows',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 400,
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: _buildTiles(imagePaths),
          ),
        )
      ],
    );
  }

  List<StaggeredGridTile> _buildTiles(List<String> imagePaths) {
    List<StaggeredGridTile> tiles = [];
    int maxPhotosToShow = 2;

    for (int i = 0; i < imagePaths.length && i < maxPhotosToShow; i++) {
      tiles.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: i == 0 ? 4 : 2,
          child: ImageTile(imagePath: imagePaths[i]),
        ),
      );
    }

    if (imagePaths.length > maxPhotosToShow) {
      tiles.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: ImageTile(
            imagePath: imagePaths[maxPhotosToShow],
            showOverlay: true,
            overlayText: '+${imagePaths.length - maxPhotosToShow}',
          ),
        ),
      );
    }

    return tiles;
  }
}

class ImageTile extends StatelessWidget {
  final String imagePath;
  final bool showOverlay;
  final String overlayText;

  const ImageTile({
    Key? key,
    required this.imagePath,
    this.showOverlay = false,
    this.overlayText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
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

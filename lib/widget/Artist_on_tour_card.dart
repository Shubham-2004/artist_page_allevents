import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArtistOnTourCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int showCount;
  final bool isFollowed;
  final VoidCallback onFollowToggle;

  ArtistOnTourCard({
    required this.imageUrl,
    required this.name,
    required this.showCount,
    required this.isFollowed,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 92.0,
                height: 92.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 8.0),
            Text(
              name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 2.5),
            Text(
              '$showCount Shows',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: onFollowToggle,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: isFollowed ? Colors.blue : Colors.blue,
                minimumSize: Size(100.0, 30.0),
              ),
              child: Text(
                isFollowed ? 'Following' : 'Follow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:artist_page/widget/Artist_on_tour_card.dart';

class ArtistOnTourList extends StatelessWidget {
  final List<Map<String, dynamic>> artists;
  final ValueChanged<int> onFollowToggle;

  ArtistOnTourList({
    required this.artists,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ArtistOnTourCard(
          imageUrl: artist['imageUrl'],
          name: artist['name'],
          showCount: artist['showCount'],
          isFollowed: artist['isFollowed'],
          onFollowToggle: () {
            onFollowToggle(index);
          },
        );
      },
    );
  }
}

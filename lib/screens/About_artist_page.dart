import 'package:artist_page/widget/Horizontal_divider.dart';
import 'package:artist_page/widget/Latest_album_widget.dart';
import 'package:artist_page/widget/More_photos_to_show.dart';
import 'package:artist_page/widget/Social_icon_row.dart';
import 'package:artist_page/widget/about_artist.dart';
import 'package:artist_page/widget/artist_story_list_view.dart';
import 'package:flutter/material.dart';

class AboutArtistPage extends StatelessWidget {
  const AboutArtistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: HorizontalDivider(),
          ),
          LatestAlbumWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 17.0, bottom: 20),
            child: HorizontalDivider(),
          ),
          ArtistAbout(
            artistName: 'Taylor Swift',
            aboutArtist:
                'Swift signed with Big Machine Records in 2005, starting as a country pop singer with her first two albums Taylor Swift (2006) and Fearless (2008). Their singles "Teardrops ',
          ),
          SocialIconsRow(),
          HorizontalDivider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PhotoGrid(),
          ),
          ArtistStoryListView(),
        ],
      ),
    );
  }
}

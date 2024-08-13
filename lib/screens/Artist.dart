import 'package:artist_page/widget/Horizontal_divider.dart';
import 'package:artist_page/widget/More_photos_to_show.dart';
import 'package:artist_page/widget/Social_icon_row.dart';
import 'package:artist_page/widget/about_artist.dart';
import 'package:artist_page/widget/artist_page_sel_button.dart';
import 'package:flutter/material.dart';

class AboutArtist extends StatefulWidget {
  const AboutArtist({Key? key}) : super(key: key);

  @override
  _AboutArtistState createState() => _AboutArtistState();
}

class _AboutArtistState extends State<AboutArtist> {
  int selectedIndex = 0;

  void onTabTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Page'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomTabButton(
                  title: 'All Events',
                  isSelected: selectedIndex == 0,
                  onTap: () => onTabTap(0),
                ),
                CustomTabButton(
                  title: 'About Artist',
                  isSelected: selectedIndex == 1,
                  onTap: () => onTabTap(1),
                ),
              ],
            ),
            Container(
              child: selectedIndex == 0
                  ? Center(child: Text('All Events Content'))
                  : ArtistAbout(
                      artistName: 'Taylor Swift',
                      aboutArtist:
                          'Swift signed with Big Machine Records in 2005, starting as a country pop singer with her first two albums Taylor Swift (2006) and Fearless (2008). Their singles "Teardrops ',
                    ),
            ),
            SocialIconsRow(),
            SizedBox(height: 10),
            HorizontalDivider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: PhotoGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:artist_page/screens/About_artist_page.dart';
import 'package:artist_page/screens/Allevents_page.dart';
import 'package:flutter/material.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Artist Page'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                dividerColor: Colors.black,
                dividerHeight: 0,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(text: 'All Events'),
                  Tab(text: 'About Artist'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllEventsPage(),
                  AboutArtistPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

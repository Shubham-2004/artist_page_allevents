import 'package:artist_page/widget/artist_story_list_view.dart';
import 'package:flutter/material.dart';

class AllEventsPage extends StatelessWidget {
  const AllEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ArtistStoryListView(),
      ),
    );
  }
}

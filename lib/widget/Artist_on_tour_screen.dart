import 'package:flutter/material.dart';
import 'package:artist_page/widget/Artist_on_tour_filterchip.dart';
import 'package:artist_page/widget/Artist_on_tour_list.dart';

class ArtistOnTourScreen extends StatefulWidget {
  @override
  _ArtistOnTourScreenState createState() => _ArtistOnTourScreenState();
}

class _ArtistOnTourScreenState extends State<ArtistOnTourScreen> {
  List<String> _filters = ['Near you', 'Popular', 'Music', 'Comedy', 'Video'];
  String _selectedFilter = 'Near you';
  List<Map<String, dynamic>> _artists = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _updateArtists();
  }

  List<Map<String, dynamic>> _getFilteredArtists(String filter) {
    final allArtists = {
      'Near you': [
        {
          'imageUrl':
              'https://th.bing.com/th/id/OIP.H0vdE1nX5hGx7aKjUIRd0AAAAA?rs=1&pid=ImgDetMain',
          'name': 'Drake OST',
          'showCount': 13,
          'isFollowed': false
        },
        {
          'imageUrl':
              'https://th.bing.com/th/id/OIP.XIqcyy6o16ZhXN4qIHY2yQAAAA?rs=1&pid=ImgDetMain',
          'name': 'Imagine Discovery',
          'showCount': 18,
          'isFollowed': false
        },
      ],
      'Popular': [
        {
          'imageUrl':
              'https://th.bing.com/th/id/OIP.oXGp5vXW43QvAiZ_pqFlMAAAAA?rs=1&pid=ImgDetMain',
          'name': '24 Pianos',
          'showCount': 8,
          'isFollowed': false
        },
      ],
      'Music': [
        {
          'imageUrl':
              'https://toptenfamous.com/wp-content/uploads/2021/05/Katy-Perry.jpg',
          'name': 'The Lone Wolf',
          'showCount': 22,
          'isFollowed': false
        },
      ],
      'Comedy': [
        {
          'imageUrl':
              'https://th.bing.com/th/id/OIP.FoGr2A4VoMeN68WDD1YisAHaFJ?rs=1&pid=ImgDetMain',
          'name': 'Harmony Band',
          'showCount': 15,
          'isFollowed': false
        },
      ],
      'Video': [
        {
          'imageUrl': 'https://example.com/video-artist.jpg',
          'name': 'The Video Artist',
          'showCount': 5,
          'isFollowed': false
        },
      ],
    };

    return allArtists[filter] ?? [];
  }

  void _updateArtists() {
    setState(() {
      _artists = _getFilteredArtists(_selectedFilter);
    });
  }

  void _onFilterChipSelected(String filter) {
    _pageController.animateToPage(
      _filters.indexOf(filter),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedFilter = filter;
      _updateArtists();
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedFilter = _filters[index];
      _updateArtists();
    });
  }

  void _toggleFollowStatus(int index) {
    setState(() {
      _artists[index]['isFollowed'] = !_artists[index]['isFollowed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Artist On Tour",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Pass the current page index to the filter chip
            ArtistOnTourFilterchip(
              selectedChip: _selectedFilter,
              currentPageIndex: _filters.indexOf(_selectedFilter),
              onChipSelected: _onFilterChipSelected,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  return ArtistOnTourList(
                    artists: _artists,
                    onFollowToggle: _toggleFollowStatus,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

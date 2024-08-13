import 'package:flutter/material.dart';

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({Key? key}) : super(key: key);

  void _onIconTap(String url) {
    // Implement your URL launch logic here
    print('Opening $url');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildIconButton(
              'assets/social_media/instagram.png', 'https://youtube.com'),
          const SizedBox(width: 9), // Add space between the icons
          _buildIconButton(
              'assets/social_media/youtube.png', 'https://youtube.com'),
          const SizedBox(width: 9), // Add space between the icons
          _buildIconButton(
              'assets/social_media/spotify.png', 'https://spotify.com'),
          const SizedBox(width: 9), // Add space between the icons
          _buildIconButton(
              'assets/social_media/website.png', 'https://youtube.com'),
          const SizedBox(width: 9), // Add space between the icons
          _buildIconButton(
              'assets/social_media/twitter.png', 'https://twitter.com'),
        ],
      ),
    );
  }

  Widget _buildIconButton(String assetPath, String url) {
    return InkWell(
      onTap: () => _onIconTap(url),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.grey[700],
        child: Image.asset(
          color: Colors.white,
          assetPath,
          width: 19,
          height: 19,
        ),
      ),
    );
  }
}

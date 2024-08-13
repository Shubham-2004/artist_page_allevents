import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArtistAbout extends StatelessWidget {
  final String artistName;
  final String aboutArtist;

  const ArtistAbout({
    Key? key,
    required this.artistName,
    required this.aboutArtist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About $artistName',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: aboutArtist,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
                TextSpan(
                  text: ' read more',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Add underline here
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle "read more" tap
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

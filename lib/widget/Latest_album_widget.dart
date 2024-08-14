import 'package:flutter/material.dart';

class LatestAlbumWidget extends StatelessWidget {
  const LatestAlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latest Album',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF9B7E7D),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Image.asset(
                          'assets/images/image1.jpeg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cruel Summer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Taylor Swift',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 244, 239, 239),
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                minimumSize: const MaterialStatePropertyAll(
                                    Size(50, 27)),
                              ),
                              child: const Text(
                                'PREVIEW',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle more options action
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle play action
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 10,
                child: Image.asset(
                  'assets/social_media/spotify.png',
                  color: Colors.white, // Replace with your Spotify logo asset
                  width: 15,
                  height: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

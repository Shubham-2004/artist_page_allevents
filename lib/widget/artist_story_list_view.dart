import 'package:artist_page/widget/Story_page_open.dart';
import 'package:flutter/material.dart';

class ArtistStoryListView extends StatelessWidget {
  const ArtistStoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _fetchImageUrls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading images'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No images available'));
        } else {
          return Container(
            height: 130,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffF7F4F4), width: 3),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Check the vibe",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle View All action
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 58,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final imageUrl = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InstagramStoryPage(
                              imageUrls: snapshot.data!,
                              initialIndex: index,
                              avatarUrl: "https://your-avatar-url.jpg",
                              username: "Taylor Swift",
                              timeElapsed: "18 h",
                            ),
                          ));
                        },
                        child: _buildCircularImage(imageUrl),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<String>> _fetchImageUrls() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTAPp4Cyx0uAkK3RupL-EZJ4z-BPsC01kCIoBIbfPlyW208WBn_",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMCP3RkvWSDS7LyDUgoDsXI8ctloeRFOy0wPL3ss4vBV3qhlXIwztS3Db0JEI7K4zxSZcYvpvxv0HyDX9iRSTYDAWqi6xn40unKNAipg4",
      "https://variety.com/wp-content/uploads/2024/02/Screen-Shot-2024-02-28-at-12.40.18-PM.png?w=1000&h=667&crop=1",
    ];
  }

  Widget _buildCircularImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        width: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              height: 58,
              width: 58,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}

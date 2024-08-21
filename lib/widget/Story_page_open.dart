import 'package:flutter/material.dart';

class InstagramStoryPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String avatarUrl;
  final String username;
  final String timeElapsed;

  const InstagramStoryPage({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.avatarUrl,
    required this.username,
    required this.timeElapsed,
  });

  @override
  _InstagramStoryPageState createState() => _InstagramStoryPageState();
}

class _InstagramStoryPageState extends State<InstagramStoryPage>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late PageController _pageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() {
        setState(() {});
      });

    _startAutoSlide();
  }

  void _moveToPrevious() {
    if (_currentIndex >= 0) {
      _pageController
          .previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      )
          .then((_) {
        setState(() {
          _currentIndex = _currentIndex;
        });
        forwordAnimation(isFromStart: true);
      });
    }
  }

  void _moveToNext() {
    if (_currentIndex < widget.imageUrls.length - 1) {
      _animationController.stop();
      _pageController
          .nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      )
          .then((_) {
        setState(() {
          _currentIndex = _currentIndex;
        });
        _startAutoSlide();
      });
    } else {
      Navigator.pop(context);
    }
  }

  forwordAnimation({bool isFromStart = false}) {
    _animationController.forward(from: isFromStart ? 0 : null).then((_) {
      if (_pageController.hasClients) {
        int nextPage = _currentIndex + 1;
        if (nextPage >= widget.imageUrls.length) {
          Navigator.pop(context);
        } else {
          _pageController
              .animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          )
              .then((_) {
            setState(() {
              _currentIndex = nextPage;
            });
            _startAutoSlide();
          });
        }
      }
    });
  }

  void _startAutoSlide() {
    forwordAnimation(isFromStart: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onLongPress: () => _animationController.stop(),
          onLongPressUp: () {
            forwordAnimation();
          },
          onTapUp: (details) {
            final width = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx < width / 2) {
              _moveToPrevious();
            } else {
              _moveToNext();
            }
          },
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  _animationController.stop();
                  setState(() {
                    _currentIndex = index;
                  });
                  _startAutoSlide();
                },
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),
              Positioned(
                top: 25,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://variety.com/wp-content/uploads/2024/02/Screen-Shot-2024-02-28-at-12.40.18-PM.png?w=1000&h=667&crop=1"),
                          radius: 18,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 6,
                left: 0,
                right: 0,
                child: Row(
                  children: List.generate(widget.imageUrls.length, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: LinearProgressIndicator(
                          value: _currentIndex > index
                              ? 1.0
                              : (_currentIndex == index
                                  ? _animationController.value
                                  : 0.0),
                          backgroundColor: Colors.white30,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

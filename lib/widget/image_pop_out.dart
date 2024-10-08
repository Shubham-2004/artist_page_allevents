import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(title: const Text('Hero Sample')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          ListTile(
            leading: const Hero(
              tag: 'hero-rectangle',
              child: BoxWidget(size: Size(50.0, 50.0)),
            ),
            title: const Text(
              'Tap on the icon to view hero animation transition.',
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) => const SecondPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double _dragOffsetY = 0.0;
  double _scale = 1.0;

  final double dragLimit = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: GestureDetector(
        child: Center(
          child: Transform.scale(
            scale: _scale,
            child: Transform.translate(
              offset: Offset(0, _dragOffsetY),
              child: PhotoView(
                imageProvider: NetworkImage(
                  'https://toptenfamous.com/wp-content/uploads/2021/05/Katy-Perry.jpg',
                ),
                minScale: PhotoViewComputedScale.contained * 0.7,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes:
                    const PhotoViewHeroAttributes(tag: 'hero-rectangle'),
              ),
            ),
          ),
        ),
        onVerticalDragUpdate: (details) {
          setState(() {
            _dragOffsetY += details.delta.dy;
            if (_dragOffsetY > dragLimit) {
              _dragOffsetY = dragLimit;
            } else if (_dragOffsetY < -dragLimit) {
              _dragOffsetY = -dragLimit;
            }

            _scale = 1 - (_dragOffsetY.abs() / dragLimit) * 0.2;
            if (_scale < 0.9) {
              _scale = 0.9;
            }
          });
        },
        onVerticalDragEnd: (details) {
          if (_dragOffsetY > 90) {
            Navigator.of(context).pop();
          } else {
            setState(() {
              _dragOffsetY = 0.0;
              _scale = 1.0;
            });
          }
        },
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: Image.network(
        'https://toptenfamous.com/wp-content/uploads/2021/05/Katy-Perry.jpg',
        fit: BoxFit.contain,
      ),
    );
  }
}

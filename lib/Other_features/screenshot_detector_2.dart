import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenshotDetector2 extends StatefulWidget {
  const ScreenshotDetector2({super.key});

  @override
  State<ScreenshotDetector2> createState() => _ScreenshotDetector2State();
}

class _ScreenshotDetector2State extends State<ScreenshotDetector2> {
  final _currentScreen = ValueNotifier<String>('Home');
  final _screenshotDuration = const Duration(seconds: 2);
  final _pageMap = {
    'Home': const HomePageContent(),
    'Settings': const SettingsPageContent(),
    'Profile': const ProfilePageContent(),
  };

  static const platform = MethodChannel('com.example.screenshot/detection');

  @override
  void initState() {
    super.initState();
    _currentScreen.value = 'Home';
    _startScreenshotListener();
  }

  void _startScreenshotListener() {
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == "onScreenshotTaken") {
        final String page = _currentScreen.value;
        _showScreenshotSnackbar(context, page);
      }
    });
  }

  void _showScreenshotSnackbar(BuildContext context, String pageName) {
    final snackBar = SnackBar(
      content: Text('Screenshot taken on the $pageName page!'),
      duration: _screenshotDuration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot Detection'),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<String>(
            valueListenable: _currentScreen,
            builder: (context, value, child) => _pageMap[value]!,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getPageIndex(),
        onTap: (index) {
          String selectedPage = _getPageName(index);
          _currentScreen.value = selectedPage;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _getPageIndex() {
    switch (_currentScreen.value) {
      case 'Settings':
        return 1;
      case 'Profile':
        return 2;
      case 'Home':
      default:
        return 0;
    }
  }

  String _getPageName(int index) {
    switch (index) {
      case 1:
        return 'Settings';
      case 2:
        return 'Profile';
      case 0:
      default:
        return 'Home';
    }
  }
}

// Example Home Page Content
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You are on the Home page',
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

// Example Settings Page Content
class SettingsPageContent extends StatelessWidget {
  const SettingsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You are on the Settings page',
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

// Example Profile Page Content
class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You are on the Profile page',
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

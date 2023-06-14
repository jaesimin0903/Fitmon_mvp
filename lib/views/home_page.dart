import 'package:flutter/material.dart';
import 'category_page.dart';
import 'shop_page.dart';
import 'user_page.dart';
import 'excercise_page.dart';
import 'camera_page.dart';
import 'package:camera/camera.dart';

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;
  MyHomePage({Key? key, required this.camera}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      CategoryPage('Category 1'),
      ShopPage('Category 2'),
      CameraScreen(camera: widget.camera),
      WorkoutPage(),
      RankingPage(),
    ];
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromARGB(255, 10, 25, 35),
        unselectedItemColor: Colors.grey,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '상점',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: '오운완',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.run_circle_outlined),
            label: '운동',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '내 정보',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

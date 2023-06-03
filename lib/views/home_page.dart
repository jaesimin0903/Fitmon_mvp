import 'package:flutter/material.dart';
import 'category_page.dart';
import 'shop_page.dart';
import 'user_page.dart';
import 'excercise_page.dart';
import 'camera_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CategoryPage('Category 1'),
    ShopPage('Category 2'),
    CameraScreen(),
    WorkoutPage(),
    RankingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Category 1',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Category 2',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Category 3',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Category 4',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Category 5',
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

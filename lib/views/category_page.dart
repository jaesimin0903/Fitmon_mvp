import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';
import 'chat.dart';

class CategoryPage extends StatelessWidget {
  final String categoryTitle;

  CategoryPage(this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Image.asset(avatarData.avatarImage),
                Text('Name: ${avatarData.name}'),
                Text('Points: ${avatarData.points}'),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  child: Text('Button 1'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Button 2'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Button 3'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Button 4'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';
import '../models/item.dart';
import 'myItem_page.dart';

class User {
  final String name;
  final int points;

  User(this.name, this.points);
}

List<User> users = [
  User('You', 1350),
  User('Friend 1', 1400),
  User('Friend 2', 1300),
  User('Friend 3', 1200),
  User('Friend 4', 1100),
  // Add more friends...
];

class RankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
    // Sort the user list based on points
    users.sort((a, b) => b.points.compareTo(a.points));
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: Column(
        children: [
          Container(
              child: Column(
            children: [
              Image.asset(avatarData.avatarImage),
              Text('Name: ${avatarData.name}'),
              Text('Points: ${avatarData.points}'),
            ],
          )),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        users[index].name == 'You' ? Colors.blue : Colors.grey,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(users[index].name),
                  subtitle: Text('Points: ${users[index].points}'),
                  trailing: users[index].name == 'You'
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

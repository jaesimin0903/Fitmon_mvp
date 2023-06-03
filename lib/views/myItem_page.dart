import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';

class MyItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Items'),
      ),
      body: ListView.builder(
        itemCount: avatarData.ownedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
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
            ),
            title: Text(avatarData.ownedItems[index].name),
            subtitle: Text(avatarData.ownedItems[index].description),
          );
        },
      ),
    );
  }
}

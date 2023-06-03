import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';
import '../models/item.dart';
import 'myItem_page.dart';

class ShopPage extends StatelessWidget {
  final String categoryTitle;
  final List<Item> items = [
    Item(
        name: 'Hat',
        description: 'A stylish hat.',
        price: 20,
        image: 'images/hat.png'),
    Item(
        name: 'Shirt',
        description: 'A cool shirt.',
        price: 50,
        image: 'images/shirt.png'),
    Item(
        name: 'Shoes',
        description: 'A pair of shoes.',
        price: 100,
        image: 'images/shoes.png'),
    Item(
        name: 'Glasses',
        description: 'Fancy glasses.',
        price: 40,
        image: 'images/glasses.png'),
    Item(
        name: 'Dumbbells',
        description: 'Exercise equipment.',
        price: 150,
        image: 'images/dumbbells.png'),
  ];

  ShopPage(this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Image.asset(avatarData.avatarImage)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyItemsPage()),
                      );
                    },
                    child: Text('My Items'),
                  ),
                ),
              ],
            ),
            Text('Welcome to the shop!'),
            Text('You have ${avatarData.points} points'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
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
                  title: Text(items[index].name),
                  subtitle: Text(items[index].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${items[index].price} points',
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                          width:
                              10), // provide some spacing between the price and the button
                      ElevatedButton(
                        onPressed: avatarData.hasItem(items[index])
                            ? null
                            : () {
                                if (avatarData.points >= items[index].price) {
                                  avatarData.spendPoints(items[index].price);
                                  avatarData.addItem(items[index]);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Item purchased!')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Not enough points!')));
                                }
                              },
                        child: Text('Buy'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

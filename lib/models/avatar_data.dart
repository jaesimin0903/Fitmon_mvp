import 'package:flutter/material.dart';
import 'item.dart';
import 'excercise.dart';

class AvatarData with ChangeNotifier {
  String avatarImage = 'lib/assets/images/default_avatar.png';
  String name = 'User';
  int points = 1000;
  List<Item> ownedItems = [];
  List<Exercise> myEx = [];

  void addItem(Item item) {
    ownedItems.add(item);
    notifyListeners();
  }

  void spendPoints(int amount) {
    points -= amount;
    notifyListeners();
  }

  void addExc(Exercise ex) {
    myEx.add(ex);
  }

  bool hasItem(Item item) {
    return ownedItems.contains(item);
  }
}

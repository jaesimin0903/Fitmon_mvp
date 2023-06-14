import 'package:flutter/material.dart';
import 'item.dart';
import 'excercise.dart';

class AvatarData with ChangeNotifier {
  String avatarImage = "lib/assets/images/level1.png";

  String name = 'User';
  int level = 1;
  List<int> expForLevel = [400, 2000, 5000, 10000];
  int exp = 0;
  int points = 1000;
  List<Item> ownedItems = [];
  List<Exercise> myEx = [];

  void changeImg() {
    if (level == 1) {
      avatarImage = "lib/assets/images/level1.png";
    } else if (level == 2 &&
        ownedItems.any((element) => element.name == "Dumbbells")) {
      avatarImage = "lib/assets/images/pink.png";
    } else if (level == 2) {
      avatarImage = "lib/assets/images/level2.png";
    }
    print(
        level == 2 && ownedItems.any((element) => element.name == "Dumbbells"));
  }

  void levelUp() {
    level += 1;
    changeImg();
    notifyListeners();
  }

  void addExp(int e) {
    exp += e;
    canLevelUP();
    notifyListeners();
  }

  void addItem(Item item) {
    ownedItems.add(item);
    ownedItems.forEach((element) => print(element.name));
    changeImg();
    notifyListeners();
  }

  void spendPoints(int amount) {
    points -= amount;
    notifyListeners();
  }

  void addExc(Exercise ex) {
    myEx.add(ex);
    notifyListeners();
  }

  void canLevelUP() {
    if (exp >= expForLevel[level - 1]) {
      exp -= expForLevel[level - 1];
      levelUp();
    }
  }

  bool hasItem(Item item) {
    return ownedItems.contains(item);
  }
}

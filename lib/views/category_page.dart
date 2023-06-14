import 'package:flutter/material.dart';
import 'package:flutter_chat/views/excercise_page.dart';
import 'package:flutter_chat/views/game_page.dart';
import 'package:flutter_chat/views/workoutChart_page.dart';
import 'package:flutter_chat/views/workout_watch.dart';
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
      backgroundColor: Color.fromRGBO(10, 28, 35, 1),
      appBar: AppBar(
        title: Text('홈'),
        backgroundColor: Color.fromRGBO(10, 28, 35, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white,
                    child: Image.asset(avatarData.avatarImage)),
                Text(
                  '이름 : ${avatarData.name}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Level: ${avatarData.level} EXP: ${avatarData.exp}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Points: ${avatarData.points}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              padding: const EdgeInsets.all(20.0),
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
                  child: Text(
                    '트레이너 봇',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutWatch()),
                    );
                  },
                  child: Text(
                    '스마트워치 화면',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: Text(
                    '미니게임 \n화면',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LineChartSample2()));
                  },
                  child: Text(
                    '운동분석 \n화면',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

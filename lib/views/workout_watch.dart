import 'package:flutter/material.dart';
import '../models/avatar_data.dart';
import 'package:provider/provider.dart';

import 'dart:async';

class WorkoutWatch extends StatefulWidget {
  const WorkoutWatch({super.key});

  @override
  State<WorkoutWatch> createState() => _WorkoutWatchState();
}

class _WorkoutWatchState extends State<WorkoutWatch> {
  String? selectedCategory;
  String? selectedExercise;

  List<String> chestExercises = ['Bench Press', 'Incline Bench Press', 'Dips'];

  late Timer _timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        counter++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 28, 35, 1),
      appBar: AppBar(
        title: Text('Apple Watch Screen'),
        backgroundColor: Color.fromRGBO(10, 28, 35, 1),
      ),
      body: Container(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 90,
                backgroundColor: Colors.white,
                child: Image.asset(avatarData.avatarImage)),
            if (selectedCategory == null) ...[
              ElevatedButton(
                child: Text('Start Workout'),
                onPressed: () {
                  setState(() {
                    selectedCategory = 'chest';
                  });
                },
              ),
            ] else if (selectedCategory == 'chest' &&
                selectedExercise == null) ...[
              for (var exercise in chestExercises)
                ElevatedButton(
                  child: Text(exercise),
                  onPressed: () {
                    setState(() {
                      selectedExercise = exercise;
                    });
                  },
                ),
            ] else ...[
              Text('You selected $selectedExercise',
                  style: TextStyle(color: Colors.white)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("운동횟수"),
                      ),
                    ),
                    Text('$counter', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("운동량"),
                      ),
                    ),
                    Text('${counter * 5}',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () =>
                      {avatarData.addExp(counter * 5), Navigator.pop(context)},
                  child: Text('운동종료'))
            ],
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: Text('Apple Watch Screen'),
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
              Text('You selected $selectedExercise'),
              Text('횟수 : $counter'),
              Text('운동량 :${counter * 5}'),
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

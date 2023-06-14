import 'package:flutter/material.dart';
import '../models/excercise.dart';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Exercise> _exercises = [];
  String? _selectedCategory;
  String? _selectedName;
  int _weight = 0;
  String _reps = "";
  String _sets = "";

  // Fill this with your categories
  List<String> _names = [
    '스쿼트',
    '데드리프트',
    '플랭크'
  ]; // Fill this with your exercise names

  void _addExercise() {
    print("_addExercise");
    if (_selectedName == null) {
      // Show an error message or something
      return;
    }
    setState(() {
      print("setState");
      _exercises.add(Exercise(
          name: _selectedName!, weight: _weight, reps: _reps, sets: _sets));
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    // Assuming your AvatarData has a List<Exercise> named exercises
    _exercises = Provider.of<AvatarData>(context, listen: false).myEx;
  }

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    _exercises = context.watch<AvatarData>().myEx;
    return Scaffold(
      appBar: AppBar(
        title: Text('운동 관리'),
      ),
      body: Column(
        children: [
          ..._exercises
              .map((exercise) => ListTile(
                    title: Text('${exercise.name}'),
                    subtitle: Text(
                        '무게: ${exercise.weight}kg, 횟수: ${exercise.reps}, 세트: ${exercise.sets}'),
                    trailing: Checkbox(
                      value: exercise.isChecked,
                      onChanged: (value) {
                        setState(() {
                          exercise.isChecked = value ?? false;
                        });
                      },
                    ),
                  ))
              .toList(),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton<String>(
                              value: _selectedName,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedName = newValue ?? '0';
                                });
                              },
                              items: _names.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            TextField(
                              onChanged: (value) => _weight = int.parse(value),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: '무게',
                              ),
                            ),
                            TextField(
                              onChanged: (value) => _reps = value,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: '횟수',
                              ),
                            ),
                            TextField(
                              onChanged: (value) => _sets = value,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: '세트',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _addExercise,
                              child: Text('운동 추가'),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
            child: Text('운동 추가'),
          ),
        ],
      ),
    );
  }
}

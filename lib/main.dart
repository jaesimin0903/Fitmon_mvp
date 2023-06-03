import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat/models/avatar_data.dart';
import 'package:flutter_chat/views/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AvatarData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat/models/avatar_data.dart';
import 'package:flutter_chat/views/home_page.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(ChangeNotifierProvider(
    create: (context) => AvatarData(),
    child: MyApp(camera: firstCamera),
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp({required this.camera});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(camera: camera),
    );
  }
}

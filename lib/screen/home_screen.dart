import 'package:flutter/material.dart';
import 'package:wallpaper/constants/Strings.dart';
import 'package:wallpaper/screen/category.dart';
import 'package:wallpaper/screen/image_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Category(),
          Expanded(child: ImageGrid()),
        ],
      ),
    );
  }
}

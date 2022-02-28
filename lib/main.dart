import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_page.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>
 runApp(WallpaperApp()) );
}
class WallpaperApp extends StatelessWidget {
  const WallpaperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "wallpaper",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

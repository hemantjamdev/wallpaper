import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/ad_helper/ad_helper.dart';
import 'package:wallpaper/module/wallpaper_grid/grid_bloc.dart';
import 'package:wallpaper/routes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  AdHelper.initializeAd();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(WallpaperApp()));
}

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GridBloc(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        title: "wallpaper",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: '/',
      ),
    );
  }
}

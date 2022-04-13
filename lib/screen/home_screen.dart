import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaper/ad_helper/ad_helper.dart';
import 'package:wallpaper/constants/Strings.dart';
import 'package:wallpaper/screen/category.dart';
import 'package:wallpaper/screen/image_grid.dart';
import 'package:wallpaper/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  Widget buildAdWidget() {
    return SizedBox(
      height: AdHelper.wallpaperGridBannerAd.size.height.toDouble(),
      child: AdWidget(ad: AdHelper.wallpaperGridBannerAd),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.title), centerTitle: true),
      body: Column(
        children: [
          searchBar(controller, context),
          Category(),
          Expanded(child: ImageGrid()),
        ],
      ),
      bottomNavigationBar: buildAdWidget(),
    );
  }
}

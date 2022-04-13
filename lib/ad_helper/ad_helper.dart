import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String wallpaperGridBannerId =
      'ca-app-pub-8064702179639632/7367419169';
  static String wallpaperDetailsBannerId =
      'ca-app-pub-8064702179639632/8743207871';

  // static String testId = 'ca-app-pub-3940256099942544/6300978111';

  static late BannerAd wallpaperGridBannerAd;
  static late BannerAd wallpaperDetailsBannerAd;

  static void initializeAd() {
    wallpaperGridAd();
    wallpaperDetailAd();
  }

  static void wallpaperGridAd() async {
    wallpaperGridBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: wallpaperGridBannerId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await wallpaperGridBannerAd.load();
  }

  static void wallpaperDetailAd() async {
    wallpaperDetailsBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: wallpaperDetailsBannerId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await wallpaperDetailsBannerAd.load();
  }
}

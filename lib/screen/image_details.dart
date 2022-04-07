import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class ImageDetails extends StatefulWidget {
  final Map<dynamic, String> map;

  const ImageDetails({Key? key, required this.map}) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  bool isConnection = true;

  showToast(String msg) => Fluttertoast.showToast(msg: msg);

  /// connectivity checking
  void checkConnectivity() async {
    try {
      final res = await InternetAddress.lookup('google.com');
      if (res.isNotEmpty && res.first.rawAddress.isNotEmpty)
        isConnection = true;
    } on SocketException catch (e) {
      print(e);
      isConnection = false;
    }
    setState(() {});
  }

  /// set wallpaper
  Future setWallpaper(BuildContext context, String imageUrl) async {
    Navigator.of(context, rootNavigator: true).pop();
    onLoading(val: true, loadingText: 'loading...', context: context);
    try {
      Future.delayed(Duration(milliseconds: 100), () async {
        var file = await DefaultCacheManager().getSingleFile(imageUrl);
        Future.delayed(Duration(milliseconds: 200), () {
          WallpaperManagerFlutter()
              .setwallpaperfromFile(file, WallpaperManagerFlutter.HOME_SCREEN);
        });

        onLoading(val: false, loadingText: 'waiting', context: context);

        showToast('Wallpaper set');
      });
    } catch (e) {
      print('Failed to get wallpaper.');
    }
  }

  /// download image
  downloadImage(String imageUrl, BuildContext context) async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        onLoading(val: true, loadingText: 'downloading', context: context);
        var imageId = await ImageDownloader.downloadImage(imageUrl)
            ;
        onLoading(val: false, loadingText: 'downloading', context: context);

        var path = await ImageDownloader.findPath(imageId!);
        showToast('Image Downloaded : $path');
      } else if (status.isDenied) {
        showToast('Storage permission is necessary for download');
      } else if (status.isRestricted) {
        showToast('Storage permission is necessary for download');
      } else if (status.isPermanentlyDenied) {
        showToast('Allow permission from app setting');
      } else {
        await Permission.storage.request();
      }
    } on PlatformException catch (e) {
      showToast('can not find image');
      print("$e");
    }
  }

  /// share iamge
  shareImage(String imageUrl, BuildContext context) async {
    try {
      var status = await Permission.storage.request();
      var imageId;
      if (status.isGranted) {
        onLoading(val: true, loadingText: 'saving', context: context);
        imageId = await ImageDownloader.downloadImage(imageUrl);
        onLoading(val: false, loadingText: 'saving', context: context);
        var path = await ImageDownloader.findPath(imageId);
        await Share.shareFiles([path.toString()]);
      } else if (status.isDenied) {
        showToast('Storage permission is required for download');
      } else if (status.isRestricted) {
        showToast('Storage permission is required for download');
      } else if (status.isPermanentlyDenied) {
        showToast('Allow permission from app setting');
      } else {
        return await Permission.storage.request();
      }

      if (imageId == null) {
        showToast('can not find image');
      }
    } on PlatformException catch (error) {
      showToast('can not find image');
      print(error);
    }
  }

  /// loading indicator
  onLoading(
      {required bool val,
      required String loadingText,
      required BuildContext context}) {
    if (val) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: SimpleDialog(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          loadingText,
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (!val) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      return;
    }
  }

  openDialog(BuildContext context, String imageUrl) {
    return showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: AlertDialog(
          insetPadding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          title: Text(
            'Set image as wallpaper ?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('cancel')),
            TextButton(
                onPressed: () async {
                  await setWallpaper(context, imageUrl);
                },
                child: Text('set')),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Hero(
            tag: widget.map['imageUrl']!,
            child: CachedNetworkImage(
              imageUrl: widget.map['imageUrl']!,
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Platform.isAndroid
                    ? openDialog(context, widget.map['imageUrl']!)
                    : showToast("currently not support on iOS");
              },
              icon: Icon(Icons.image),
            ),
            IconButton(
              onPressed: () {
                isConnection
                    ? downloadImage(widget.map['imageUrl']!, context)
                    : showToast("no internet connection");
              },
              icon: Icon(Icons.download_rounded),
            ),
            IconButton(
              onPressed: () {
                isConnection
                    ? shareImage(widget.map['imageUrl']!, context)
                    : showToast("no internet connection");
              },
              icon: Icon(Icons.share),
            ),
          ],
        ),
      ),
    );
  }
}

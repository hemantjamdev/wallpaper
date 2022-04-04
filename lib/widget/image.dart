import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/screens/image_details.dart';

Widget imageWidget(
    {required BuildContext context,
    required String name,
    required String url}) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ImageDetails(imageName: name, imageUrl: url))),
    child: Hero(
      tag: 'hero1',
      child: CachedNetworkImage(
        imageUrl: url,
      ),
    ),
  );
}

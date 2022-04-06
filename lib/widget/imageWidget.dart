import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/module/image_details/image_details.dart';

Widget imageWidget(
    {required BuildContext context,
    required String name,
    required String url}) {
  return InkWell(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ImageDetails(imageName: name, imageUrl: url))),
    child: Hero(
tag: url,
      child: CachedNetworkImage(
        imageUrl: url,
      ),
    ),
  );
}

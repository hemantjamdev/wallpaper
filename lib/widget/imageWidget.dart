import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget imageWidget(
    {required BuildContext context,
    required String name,
    required String url,
    required String thumbNail}) {
  return InkWell(
    onTap: () {
      Map<dynamic, String> args = {'imageName': name, 'imageUrl': url};
      Navigator.pushNamed(context, '/details', arguments: args);
    },
    child: Hero(
      tag: url,
      child: CachedNetworkImage(imageUrl: thumbNail),
    ),

  );
}

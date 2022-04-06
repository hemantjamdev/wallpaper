import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDetails extends StatefulWidget {
  final String imageName;
  final String imageUrl;

  const ImageDetails({
    Key? key,
    required this.imageName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.imageName),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Hero(
            tag: widget.imageUrl,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.image),
            Icon(Icons.download_rounded),
            Icon(Icons.share)
          ],
        ),
      ),
    );
  }
}

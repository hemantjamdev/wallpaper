import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/constants/Strings.dart';
import 'package:wallpaper/model/image_model.dart';
import 'package:wallpaper/widget/imageWidget.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  ImageModel? imageModel;
  final _controller = ScrollController();
  int perPage = 200;
  bool loadImage = false;
int page=1;
  getImages(int perPage) async {
    var res = await http.get(
        Uri.parse(Strings.API + "curated?per_page=$perPage&page=$page"),
        headers: {"Authorization": Strings.API_KEY});
    if (res.statusCode == 200) {
      setState(() {
        Map<String, dynamic> body = jsonDecode(res.body);
        imageModel = ImageModel.fromJson(body);
        loadImage = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getImages(perPage);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
         // perPage==100?page=2:page=page;
         // perPage==100?perPage=10:perPage=perPage;
          getImages(loadImage ? perPage += 10 : perPage);
          log("this is perpage ---- $perPage");
          log("this is page ---- $page");
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: imageModel == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: _controller,
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                children: imageModel!.photos!
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: imageWidget(
                              context: context,
                              url: e.src!.medium!,
                              name: e.id.toString()),
                        ))
                    .toList(),
              ),
            ),
    );
  }
}

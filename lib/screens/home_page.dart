import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper/model/image_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiKEY = "563492ad6f91700001000001e386ced37ce24f0bba8e9db72a117295";
  ImageModel imageModel = ImageModel();
  final _controller = ScrollController();
  int perPage = 10;
  getImages(int perPage) async {
    var res = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=$perPage&page=1"),
        headers: {"Authorization": apiKEY});
    if (res.statusCode == 200) {
      //log(res.body);
      setState(() {
        Map<String, dynamic> body = jsonDecode(res.body);
        imageModel = ImageModel.fromJson(body);
        //  print("this is resulted come------${imageModel.totalResults}");
      });
    }
  }

  Widget noteWidget(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getImages(perPage);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          log('At the top');
        } else {
          log('At the bottom');
          getImages(perPage + 10);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImages(perPage);
        },
      ),
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          controller: _controller,
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            children: imageModel.photos!
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: noteWidget(e.src!.original!),
                    ))
                .toList(),
          ),
        ),

        /* ListView.builder(
            shrinkWrap: true,
            itemCount: imageModel.photos!.length,
            itemBuilder: (context, int index) {
              if (imageModel.photos != null && imageModel.photos!.isNotEmpty) {
                Photos image = imageModel.photos![index];
                return ListTile(
                  leading: Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(backgroundImage: NetworkImage(image.src!.portrait!),)),
                title:  Text(image.id.toString())
                );
              } else {
                return CircularProgressIndicator();
              }
            }),*/
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';

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

  getImages() async {
    var res = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=10&page=1"),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImages();
        },
      ),
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
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
            }),
      ),
    );
  }
}

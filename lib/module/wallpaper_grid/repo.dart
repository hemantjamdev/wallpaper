import 'dart:convert';
import 'dart:developer';

import 'package:wallpaper/model/image_model.dart';
import 'package:wallpaper/module/wallpaper_grid/data_provider.dart';

class Repo {
  Future<ImageModel?> getData({required String category}) async {
    log("get data method called in repo--category====$category");
    var data = await DataProvider.getImages(category: category);
    // List<ImageModel>modelList;
    if (data != null) {
      Map<String, dynamic> body = jsonDecode(data);
      var imageModel = ImageModel.fromJson(body);
      return imageModel;
    } else {
      log('returning null');
      return null;
    }
  }
}

import 'dart:convert';

import 'package:wallpaper/model/image_model.dart';
import 'package:wallpaper/module/wallpaper_grid/data_provider.dart';

class Repo {
  Future<ImageModel?> getData({required String category}) async {
    var data = await DataProvider.getImages(category: category);

    if (data != null) {
      Map<String, dynamic> body = jsonDecode(data);
      var imageModel = ImageModel.fromJson(body);
      return imageModel;
    } else {
      return null;
    }
  }
}

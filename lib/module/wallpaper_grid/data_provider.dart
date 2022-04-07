import 'package:http/http.dart' as http;
import 'package:wallpaper/constants/Strings.dart';

class DataProvider {
  static Future getImages({required String category}) async {
    var res = await http.get(
        Uri.parse(Strings.API + "search?query=$category?per_page=10&page=1"),
        headers: {"Authorization": Strings.API_KEY});
    if (res.statusCode == 200) {
      return res.body;
    } else {
      return null;
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryServices {
  static const String cloudName = "dteufun5l";
  static const String uploadPreset = "foodgo";
  static const String apiKey = "442544757164949";
  static const String apiSecret = "SngVmn3bxUNZYj_7QGLcCTqfnVo";

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );
      final request = http.MultipartRequest("POST", url)
        ..fields["upload_preset"] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath("file", imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responsedata = await response.stream.toBytes();

        final responseString = String.fromCharCodes(responsedata);

        final jsonmap = jsonDecode(responseString);

        return jsonmap["secure_url"] as String;
      }
    } catch (e) {
      print(e);
    }
  }
}

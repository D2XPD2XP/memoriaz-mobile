import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageRestorationService {
  ImageRestorationService({String? baseUrl})
      : baseUrl = baseUrl ?? _defaultBaseUrl;

  final String baseUrl;

  static String get _defaultBaseUrl {
    if (Platform.isAndroid) return 'http://10.0.2.2:8000';
    return 'http://127.0.0.1:8000';
  }

  Future<File> restore(File image) async {
    final uri = Uri.parse('$baseUrl/restore');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode != 200) {
      throw HttpException(
        'Restorasi gagal (${response.statusCode})',
        uri: uri,
      );
    }

    final dir = await getTemporaryDirectory();
    final fileName = 'restored_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final outFile = File('${dir.path}/$fileName');
    await outFile.writeAsBytes(response.bodyBytes);

    return outFile;
  }
}

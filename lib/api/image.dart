import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:seronium_flutter/constants/index.dart';

Future<String> UploadImage(String filePath) async {
  final file = File(filePath);
  final multipartFile = MultipartFile(
    file,
    filename: filePath.split('/').last, 
  );

  final formData = FormData({
    'file': multipartFile,
  });

  final getConnect = GetConnect();
  final response = await getConnect.post(
    HTTPConstants.UPLOAD_IMAGE, 
    formData,
  );
  if (response.status.hasError) {
    throw Exception('上传失败: ${response.statusText}');
  }
  return response.body['url'];
}
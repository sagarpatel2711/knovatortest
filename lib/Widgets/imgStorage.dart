import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:resume_maker/Controller/fireDBController.dart';

import '../Utility/logger.dart';

class Storage {
  static FireDBController fireDBController = Get.put(FireDBController());
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      final imgfile = await storage.ref('userdata/$fileName').putFile(file);
      final String downloadUrl = await imgfile.ref.getDownloadURL();
      fireDBController.photoUrl = downloadUrl;
      logger.i("photot:  ${fireDBController.photoUrl}");

      return downloadUrl;
    } catch (e) {
      logger.d("Uploadfile : ${e}");
      return "";
    }
  }
}

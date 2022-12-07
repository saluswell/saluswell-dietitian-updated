import 'dart:io';

import 'package:dietationapp/common/helperFunctions/showsnackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;



class StorageServices {
  Future<String> uploadFile(File file) async {
    String fileName = path.basename(file.path);

    try {
      await Future.delayed(const Duration(milliseconds: 100));
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("documents/$fileName+${DateTime.now().toString()}");

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      final String url = await taskSnapshot.ref.getDownloadURL();

      dp(msg: "Url of file", arg: url);

      return url;
    } on Exception catch (e) {
      dp(msg: "Error in uploading", arg: e);
      rethrow;
    }
  }
}

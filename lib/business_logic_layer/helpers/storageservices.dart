import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageServices {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref(imageName).getDownloadURL();
    return downloadURL;
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

// This service handles file uploads to Firebase Storage.
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a profile picture to Firebase Storage.
  Future<String?> uploadProfilePicture(String userId, File image) async {
    try {
      // Create a reference to the location where the image will be stored.
      Reference ref = _storage.ref().child('profile_pictures').child('$userId.jpg');
      // Upload the file.
      UploadTask uploadTask = ref.putFile(image);
      // Get the download URL of the uploaded file.
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      // Handle any errors that occur during the upload.
      print('Image upload error: $e');
      return null;
    }
  }
}

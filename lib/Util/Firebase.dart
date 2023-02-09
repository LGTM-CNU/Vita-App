import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase {
  static save(File file) async {
// Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("temp1.wav");

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("voice/temp1.wav");

// While the file names are the same, the references point to different files
    assert(mountainsRef.name == mountainImagesRef.name);
    assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

    await mountainsRef.putFile(file);

    final downloadPath = await mountainsRef.getDownloadURL();

    return downloadPath;
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Firebase {
  static save(File file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final id = pref.getString("id");

    if (id == null) return "Error";

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedName = formatter.format(now);

// Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref(id);

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("$formattedName.wav");

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("$id/$formattedName.wav");

// While the file names are the same, the references point to different files
    assert(mountainsRef.name == mountainImagesRef.name);
    assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

    await mountainsRef.putFile(file);

    final downloadPath = await mountainsRef.getDownloadURL();

    return downloadPath;
  }
}

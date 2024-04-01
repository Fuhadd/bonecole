import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../view_model/local_cache/local_cache.dart';

abstract class FirebaseStorageRepository {
  Future<String> uploadImage(File image);
  Future updateImage(File image);
}

class FirebaseStorageRepositoryImpl implements FirebaseStorageRepository {
  late LocalCache cache;

  FirebaseStorageRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference firestoreRepository =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<String> uploadImage(File image) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    Reference ref = firebaseStorage.ref().child('$uid/images');
    await ref.putFile(image);
    String downloadedUrl = await ref.getDownloadURL();
    return downloadedUrl;
    // await firestoreRepository.doc(uid.toString()).set(

    //     //document().set(
    //     {
    //       'imageUrl': downloadedUrl,
    //     },
    //     SetOptions(
    //       merge: true,
    //     ));
  }

  @override
  Future updateImage(File image) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    Reference ref = firebaseStorage.ref().child('$uid/images');
    await ref.putFile(image);
    String downloadedUrl = await ref.getDownloadURL();
    await firestoreRepository.doc(uid.toString()).update(
      //document().set(
      {
        'imageUrl': downloadedUrl,
      },
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/global/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

import '../../model/menus.dart';

import '../../widgets/progress_bar.dart';
import '../../widgets/error_dialog.dart';

class ItemsUploadScreen extends StatefulWidget {
  final Menus model;
  const ItemsUploadScreen(this.model, {super.key});

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imageXFile;
  final _picker = ImagePicker();
  bool uploading = false;

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Item',
          style: TextStyle(
            fontFamily: 'Lobster-Regular',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (c) => const MenusUploadScreen(),
        //         ),
        //       );
        //     },
        //     icon: const Icon(Icons.post_add, color: Colors.white),
        //   ),
        // ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shop_two,
                color: Colors.grey,
                size: 200.0,
              ),
              ElevatedButton(
                onPressed: () {
                  takeImage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade900,
                ),
                child: const Text(
                  'Add New Item',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(ctx) {
    return showDialog(
        context: ctx,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Menu Image",
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: captureImageWithCamera,
                child: const Text(
                  'Capture With Camera',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: pickImageFromGallery,
                child: const Text(
                  'Select From Gallery',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          );
        });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async {
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  itemsUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Uploading New Item',
          style: TextStyle(
            fontFamily: 'Lobster-Regular',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            clearItemUploadForm();
          },
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (c) => const MenusUploadScreen(),
        //         ),
        //       );
        //     },
        //     icon: const Icon(Icons.post_add, color: Colors.white),
        //   ),
        // ],
        actions: [
          TextButton(
            onPressed: uploading ? null : () => validateUploadForm(),
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'VarelaRound-Regular',
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgressIndicator() : Text(""),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageXFile!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.perm_device_information, color: Colors.red.shade900),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "Menu Info",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.title, color: Colors.red.shade900),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Menu Title",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.money, color: Colors.red.shade900),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Price",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.description, color: Colors.red.shade900),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearItemUploadForm() {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      priceController.clear();
      descriptionController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        String downloadUrl = await uploadImage(
          File(imageXFile!.path),
        );

        saveInfo(downloadUrl);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Please Fill The Spaces!",
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please Pick An Image For Menu!",
            );
          });
    }
  }

  saveInfo(String downloadUrl) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model.menuID)
        .collection("items");

    ref.doc(uniqueIdName).set({
      "itemId": uniqueIdName,
      "menuId": widget.model.menuID,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text,
      "title": titleController.text,
      "price": double.parse(priceController.text),
      "description": descriptionController.text,
      "pubishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    }).then((value) {
      final itemsRef = FirebaseFirestore.instance.collection("items");
      itemsRef.doc(uniqueIdName).set({
        "itemId": uniqueIdName,
        "menuId": widget.model.menuID,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "title": titleController.text.toString(),
        "price": double.parse(priceController.text),
        "description": descriptionController.text,
        "pubishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
      });
    }).then((value) {
      clearItemUploadForm();

      setState(() {
        uniqueIdName = DateTime.now().microsecondsSinceEpoch.toString();
        uploading = false;
      });
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("items");
    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : itemsUploadFormScreen();
    //return menusUploadFormScreen();
  }
}

import 'dart:async';
import 'dart:io';
import 'package:blog/Firebase/Crud/Crud.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File? selectedImage;
  bool isLoading = false;
  final CrudMethod _crudMethod = CrudMethod();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick an image')),
      );
    }
  }

  Future<void> uploadBlog() async {
    if (selectedImage != null &&
        titleController.text.isNotEmpty &&
        descController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        // Firebase Storage reference
        firebase_storage.Reference firebaseRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child("BlogImage")
            .child("${randomAlphaNumeric(9)}.jpg");

        // Uploading the image
        firebase_storage.UploadTask uploadTask =
        firebaseRef.putFile(selectedImage!);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

        // Getting the image URL
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Blog data to be added
        Map<String, String> blogMap = {
          "imgUrl": downloadUrl,
          "title": titleController.text,
          "desc": descController.text,
        };

        // Adding blog data to Firestore
        await _crudMethod.addBlog(blogMap);

        setState(() {
          isLoading = false;
        });

        // Show success message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Blog uploaded successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("Error uploading blog: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload blog')),
        );
      }
    } else {
      print("Please fill all fields and select an image");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Flutter',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.blue),

            ),
          ],
        ),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: uploadBlog,
              child: const Icon(Icons.upload),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: selectedImage != null
                    ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.add_a_photo),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Description'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

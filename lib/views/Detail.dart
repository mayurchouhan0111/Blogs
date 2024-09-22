import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String title;
  final String desc;
  final String imgUrl;
  final String documentId;

  Detail({
    Key? key,
    required this.title,
    required this.desc,
    required this.imgUrl,
    required this.documentId,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Method to delete the blog
  Future<void> deleteBlog(String documentId, String imageUrl) async {
    try {
      // Delete the blog document from Firestore
      await FirebaseFirestore.instance
          .collection('Blog') // Replace with your collection name
          .doc(documentId) // Use the documentId passed from the widget
          .delete();

      // Delete the associated image from Firebase Storage
      firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();

      print("Blog and image deleted successfully");
      Navigator.pop(context); // Pop the current screen after deletion
    } catch (e) {
      print("Error deleting blog: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: widget.imgUrl.isNotEmpty
                          ? NetworkImage(widget.imgUrl)
                          : const AssetImage('assets/image/welcome1.jpg'),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {
                        print('Image load error: $error');
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title.isNotEmpty ? widget.title : 'No Title',
                    style: const TextStyle(
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await deleteBlog(widget.documentId, widget.imgUrl);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.desc.isNotEmpty ? widget.desc : 'No Description',
                style: const TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

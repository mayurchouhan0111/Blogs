import 'package:blog/views/Detail.dart'; // Import Detail screen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListViewFirebase extends StatelessWidget {
  final String documentId;
  final String title;
  final String desc;
  final String imgUrl;

  ListViewFirebase({
    Key? key,
    required this.documentId,
    required this.title,
    required this.desc,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(
                    documentId: documentId,
                    title: title,
                    desc: desc,
                    imgUrl: imgUrl,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imgUrl.isNotEmpty
                        ? NetworkImage(imgUrl)
                        : const AssetImage('assets/image/welcome1.jpg'),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      print('Image load error: $error');
                    },
                  ),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title.isNotEmpty ? title : 'No Title',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        desc.isNotEmpty ? desc : 'No Description',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

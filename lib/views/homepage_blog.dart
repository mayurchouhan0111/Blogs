import 'package:blog/Firebase/Crud/Crud.dart';
import 'package:blog/views/List_view_firebase.dart';
import 'package:blog/views/create_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomepageBlog extends StatefulWidget {
  const HomepageBlog({super.key});

  @override
  State<HomepageBlog> createState() => _HomepageBlogState();
}

class _HomepageBlogState extends State<HomepageBlog> {
  final CrudMethod _method = CrudMethod();
  late Future<QuerySnapshot?> _blogSnapshotFuture;

  @override
  void initState() {
    super.initState();
    _blogSnapshotFuture = _method.getData();
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
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.blue),
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot?>(
        future: _blogSnapshotFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No blogs available'));
          }

          var docs = snapshot.data?.docs;
          if (docs == null || docs.isEmpty) {
            return Center(child: Text('No blogs available'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var doc = docs[index];
              String title = doc['title'] ?? 'No Title';
              String desc = doc['desc'] ?? 'No Description';
              String imgUrl = doc['imgUrl'] ?? '';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListViewFirebase(
                  documentId: doc.id,
                  title: title,
                  desc: desc,
                  imgUrl: imgUrl,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateBlog()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

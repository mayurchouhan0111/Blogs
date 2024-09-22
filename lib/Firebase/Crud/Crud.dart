import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add blog with data passed as a Map for better scalability
  Future<void> addBlog(Map<String, String> blogData) async {
    try {
      await _firestore.collection('Blog').add({
        ...blogData, // Spreading the blog data Map to add it to Firestore
        'timestamp': FieldValue.serverTimestamp(), // Add timestamp
      });
      print('Blog added successfully');
    } catch (e) {
      print('Error adding blog: $e');
      rethrow; // Re-throwing the exception so it can be handled where needed
    }
  }

  // Fetch blog data from Firestore
  Future<QuerySnapshot?> getData() async {
    try {
      return await _firestore.collection('Blog').orderBy('timestamp', descending: true).get();
    } catch (e) {
      print('Error fetching blogs: $e');
      return null; // Returning null to handle errors in the UI side
    }
  }
}

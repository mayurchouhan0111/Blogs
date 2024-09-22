import 'package:cloud_firestore/cloud_firestore.dart';

class Firebasefunctions{


Future<void> addData(data)async{
  FirebaseFirestore.instance.collection('Blog').add(data).catchError((e){return print("e");});


}


}
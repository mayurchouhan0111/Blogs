// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-ozT-uXOGDElu98hKQ4_g-gXynyfEgjE',
    appId: '1:194813260313:web:ffd6a447207e35487bb088',
    messagingSenderId: '194813260313',
    projectId: 'blog-c6f22',
    authDomain: 'blog-c6f22.firebaseapp.com',
    storageBucket: 'blog-c6f22.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBllKUmk0SWGE2zhOf2tWlZ4NNPHTFh9bk',
    appId: '1:194813260313:android:101d620b9dc95efa7bb088',
    messagingSenderId: '194813260313',
    projectId: 'blog-c6f22',
    storageBucket: 'blog-c6f22.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjmxL2YPTwEPXlGrJLit9p4b1nQrNoPe0',
    appId: '1:194813260313:ios:8bb60c17fe5409b47bb088',
    messagingSenderId: '194813260313',
    projectId: 'blog-c6f22',
    storageBucket: 'blog-c6f22.appspot.com',
    iosBundleId: 'com.example.blog',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjmxL2YPTwEPXlGrJLit9p4b1nQrNoPe0',
    appId: '1:194813260313:ios:8bb60c17fe5409b47bb088',
    messagingSenderId: '194813260313',
    projectId: 'blog-c6f22',
    storageBucket: 'blog-c6f22.appspot.com',
    iosBundleId: 'com.example.blog',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-ozT-uXOGDElu98hKQ4_g-gXynyfEgjE',
    appId: '1:194813260313:web:ecdf05d61a7773107bb088',
    messagingSenderId: '194813260313',
    projectId: 'blog-c6f22',
    authDomain: 'blog-c6f22.firebaseapp.com',
    storageBucket: 'blog-c6f22.appspot.com',
  );
}

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDyTEes-ca7GvE1X6G-hfhikToidJUuf94',
    appId: '1:786787857896:web:4d84e85619ace0ed1ea05d',
    messagingSenderId: '786787857896',
    projectId: 'firecruds-87e2d',
    authDomain: 'firecruds-87e2d.firebaseapp.com',
    storageBucket: 'firecruds-87e2d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdD7NzHVREWUSJXOi4dw5DRY-sc0bR-z4',
    appId: '1:786787857896:android:ac3166e46833038a1ea05d',
    messagingSenderId: '786787857896',
    projectId: 'firecruds-87e2d',
    storageBucket: 'firecruds-87e2d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN06xLTGSlhmPzIUJJlEYM3GH0sy85OpE',
    appId: '1:786787857896:ios:1eafcfe468f302b51ea05d',
    messagingSenderId: '786787857896',
    projectId: 'firecruds-87e2d',
    storageBucket: 'firecruds-87e2d.appspot.com',
    iosBundleId: 'com.example.fireCruds',
  );
}

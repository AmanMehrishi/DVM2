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
        return macos;
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
    apiKey: 'AIzaSyBaXLcbfporRUP2NqWXNiO3zOOr-KcqYY8',
    appId: '1:401115411909:web:7153daa2451cb2077c47ac',
    messagingSenderId: '401115411909',
    projectId: 'oasisapp-d9962',
    authDomain: 'oasisapp-d9962.firebaseapp.com',
    storageBucket: 'oasisapp-d9962.appspot.com',
    measurementId: 'G-6DJXXSQVVZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2oPcvXvDoOsmW22XguaPSxh1bJ3NRdAs',
    appId: '1:401115411909:android:760dc5afa809e8ca7c47ac',
    messagingSenderId: '401115411909',
    projectId: 'oasisapp-d9962',
    storageBucket: 'oasisapp-d9962.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7-5aD0aVI8SYrd9KX6HRFZJfT0_Im1SM',
    appId: '1:401115411909:ios:e855d92fd7beacc07c47ac',
    messagingSenderId: '401115411909',
    projectId: 'oasisapp-d9962',
    storageBucket: 'oasisapp-d9962.appspot.com',
    iosClientId: '401115411909-p1kt6ar5pkjncteokqbj0h5frhp6oqll.apps.googleusercontent.com',
    iosBundleId: 'com.example.dvmTask2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7-5aD0aVI8SYrd9KX6HRFZJfT0_Im1SM',
    appId: '1:401115411909:ios:e855d92fd7beacc07c47ac',
    messagingSenderId: '401115411909',
    projectId: 'oasisapp-d9962',
    storageBucket: 'oasisapp-d9962.appspot.com',
    iosClientId: '401115411909-p1kt6ar5pkjncteokqbj0h5frhp6oqll.apps.googleusercontent.com',
    iosBundleId: 'com.example.dvmTask2',
  );
}

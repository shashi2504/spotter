import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBZ0U9BA0iV7WS6uVDWjbVosHZqSDiEx2o',
    appId: '1:501416583406:web:efb4bba6f5b93dc5d953ff',
    messagingSenderId: '501416583406',
    projectId: 'final-8725c',
    authDomain: 'final-8725c.firebaseapp.com',
    storageBucket: 'final-8725c.appspot.com',
    measurementId: 'G-RN6CVZ1ECV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAH4R_sPX84HYu8PehCYj0RGYhliJaJqI',
    appId: '1:501416583406:android:ef418178d0873faad953ff',
    messagingSenderId: '501416583406',
    projectId: 'final-8725c',
    storageBucket: 'final-8725c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRm7JSx0RUPNlVcEkTCyht5ZIwq0IlEM8',
    appId: '1:501416583406:ios:bf51fe7ce4fa4b6fd953ff',
    messagingSenderId: '501416583406',
    projectId: 'final-8725c',
    storageBucket: 'final-8725c.appspot.com',
    iosBundleId: 'com.example.testing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRm7JSx0RUPNlVcEkTCyht5ZIwq0IlEM8',
    appId: '1:501416583406:ios:b6c3ca28fa307542d953ff',
    messagingSenderId: '501416583406',
    projectId: 'final-8725c',
    storageBucket: 'final-8725c.appspot.com',
    iosBundleId: 'com.example.testing.RunnerTests',
  );
}

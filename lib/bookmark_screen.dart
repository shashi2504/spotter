import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 51, 97),
      ),
      body: const Center(
        child: Text(
          'Bookmark your favorite locations',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

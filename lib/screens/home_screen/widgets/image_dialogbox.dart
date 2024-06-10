import 'dart:ui';

import 'package:flutter/material.dart';

class ImageDialogbox extends StatelessWidget {
  const ImageDialogbox({super.key, required this.image});
  final MemoryImage image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        AlertDialog(
          title: Container(
            height: 300,
            width: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 2, 64, 235),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}

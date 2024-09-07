import 'package:flutter/material.dart';


class Tile extends StatelessWidget {
  final String imagePath;
  const Tile({super.key,
  required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Image.asset(imagePath, height: 80,),
    );
  }
}

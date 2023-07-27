import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final Function() onTap;
  final double size;

  const CustomCard(
      {super.key,
      required this.imageAsset,
      required this.title,
      required this.onTap,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size,
              child: Image.asset(imageAsset),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

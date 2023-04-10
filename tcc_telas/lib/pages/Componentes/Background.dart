import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Widget? components;
  Background({super.key, this.components});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF0A6066),
        width: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: Opacity(
                      opacity: 0.12,
                      child: Image.asset('image/Unicamp.png'),
                    ),
                  )
                ],
              ),
            ),
            Center(child: components),
          ],
        ));
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onStarPressed;
  final VoidCallback? onInfoPressed;
  final Function()? onLogoPressed;
  final PreferredSizeWidget? bottom;
  final bool shouldPopOnLogoPressed;

  MyAppBar(
      {this.onStarPressed,
      this.onInfoPressed,
      this.onLogoPressed,
      this.bottom,
      this.shouldPopOnLogoPressed = false});

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFA12E2F),
      leading: IconButton(
        icon: Image.asset('image/logo.png'),
        onPressed: () {
          onLogoPressed;
          if (shouldPopOnLogoPressed) {
            Navigator.pop(context);
          }
        },
      ),
      leadingWidth: 80,
      title: const Text(
        'SARsCamp',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
      ),
      titleSpacing: 0,
      actions: [
        SizedBox(
          width: 50,
          child: IconButton(
            icon: const Icon(
              Icons.star,
              size: 40,
            ),
            onPressed: onStarPressed,
          ),
        ),
        SizedBox(
          width: 50,
          child: IconButton(
            icon: const Icon(
              Icons.info,
              size: 40,
            ),
            onPressed: onInfoPressed,
          ),
        ),
      ],
      bottom: bottom,
    );
  }
}

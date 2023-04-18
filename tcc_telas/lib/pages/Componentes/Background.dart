import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Widget? components;
  Background({super.key, this.components});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF0A6066),
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
  final PreferredSizeWidget? bottom;
  final bool shouldPopOnLogoPressed;

  const MyAppBar(
      {this.bottom,
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
            onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Título do Alerta'),
                  content: const Text('Conteúdo do Alerta'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        // Lógica para quando o botão "OK" é pressionado
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: IconButton(
            icon: const Icon(
              Icons.info,
              size: 40,
            ),
            onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Título do Alerta'),
                  content: Text('Conteúdo do Alerta'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        // Lógica para quando o botão "OK" é pressionado
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            },
          ),
        ),
      ],
      bottom: bottom,
    );
  }
}

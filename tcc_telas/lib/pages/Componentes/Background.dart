import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abrirUrl() async {
  var url = Uri.parse('https://flutterando.com.br/');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Não é possível redirecionar ao link.';
  }
}

Color myGreen = Color(0xFF0A6066);

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

  const MyAppBar({this.bottom, this.shouldPopOnLogoPressed = false});

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
                      backgroundColor: Color.fromARGB(255, 210, 210, 210),
                      title: Text(
                        'Deseja avaliar o aplicativo?',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;// cor do texto do botão quando pressionado
                              }
                              return myGreen; // cor do texto do botão quando não pressionado
                            },
                          ), // cor do texto do botão// cor de fundo do botão
                          overlayColor: MaterialStateProperty.all<Color>(
                              Color(0xFF0A6066)),
                        ),
                          child: Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;// cor do texto do botão quando pressionado
                              }
                              return myGreen; // cor do texto do botão quando não pressionado
                            },
                          ), // cor do texto do botão// cor de fundo do botão
                          overlayColor: MaterialStateProperty.all<Color>(
                              Color(0xFF0A6066)),
                        ),
                          child: Text('Sim'),
                          onPressed: () {
                            abrirUrl();
                          },
                        ),
                      ],
                    );
                  });
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
                    backgroundColor: Color.fromARGB(255, 210, 210, 210),
                    title: Text(
                      'SARsCamp',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      'Este é um aplicativo que tem por objetivo oferecer aos usuários de dispositivos móveis alguns serviços corporativos envolvendo o campus I de Limeira, que possam de fato facilitar o dia a dia dos mesmos. A ideia é que o aplicativo vá agregando novos serviços a medida que seu uso se intensifique.\n\nToda nossa base de dados é obtida de serviços servidos pela Prefeitura, SAR, PU (Prefeitura Universitária Unicamp), DEA, entre outros. Para mais informações entre em contato com o SAR: \nhttps://www.sar.unicamp.br/contato\n\nPara mais informações sobre o Campus Limeira I acesse: \nhttps://www.sar.unicamp.br\n\n\n\n© Unicamp / Campus Limeira I - SAR',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      /*TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),*/
                      TextButton(
                        //ButtonStyle
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;// cor do texto do botão quando pressionado
                              }
                              return myGreen; // cor do texto do botão quando não pressionado
                            },
                          ), // cor do texto do botão// cor de fundo do botão
                          overlayColor: MaterialStateProperty.all<Color>(
                              Color(0xFF0A6066)),
                        ),
                        child: Text('OK'),
                        onPressed: () {
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

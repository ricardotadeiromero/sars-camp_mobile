import 'package:sarscamp/configs/style.dart';
import 'package:flutter/material.dart';

class ContainerSaldo extends StatelessWidget {
  final Widget input;
  ContainerSaldo({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 100),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
        width: MediaQuery.of(context).size.width * 0.7,

        decoration: BoxDecoration(
          color: myWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: myBlack.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: input,
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String text;
  const MyTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: myGreen,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 3,
                color: myGreen,
              )),
          filled: true,
          fillColor: myFillGrey,
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}

class TitleSaldoPage extends StatelessWidget {
  const TitleSaldoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 10, left: 10),
          width: 70,
          child: Image.asset('image/carteira.png'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: const Text(
            'Consulta do saldo RU',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
      ],
    ));
  }
}

class SaldoDialog extends StatelessWidget {
  final String error;
  const SaldoDialog(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFA12E2F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        'Erro',
        style: styleDialog,
      ),
      content: Wrap(
        children: [
          Center(
              child: Text(
            error,
            style: style,
          )),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: myInputGreen,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class SaldoDialogDestroy extends StatelessWidget {
  final VoidCallback act;
  const SaldoDialogDestroy({super.key, required this.act});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFA12E2F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Wrap(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text("Deseja mesmo sair?", style: styleDialog),
          )),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: myInputGreen,
          ),
          onPressed: () {
            act();
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: const Text('Sair'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return myWhite; // cor do texto do botão quando pressionado
                }
                return myWhite; // cor do texto do botão quando não pressionado
              },
            ), // cor do texto do botão// cor de fundo do botão
            overlayColor: MaterialStateProperty.all<Color>(myGreen),
          ),
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

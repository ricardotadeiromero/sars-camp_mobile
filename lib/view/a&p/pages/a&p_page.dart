import 'package:TCC/configs/style.dart';
import 'package:TCC/model/perdido.dart';
import 'package:TCC/view/components/a&pPage.dart';
import 'package:flutter/material.dart';
import 'package:TCC/view/components/background.dart';

class AchadosPerdidosPage extends StatefulWidget {
  final List<Perdido> list;
  const AchadosPerdidosPage(this.list, {super.key});

  @override
  State<AchadosPerdidosPage> createState() => _AchadosPerdidosPageState();
}

class _AchadosPerdidosPageState extends State<AchadosPerdidosPage> {
  // List<Map<String, String>> dadosDoBanco = [
  //   {
  //     'Data de Cadastro': '10/07/2023',
  //     'Material': 'Chave',
  //     'Identificação': '123456',
  //     'Local em que foi encontrado': 'Sala 101',
  //     'Campus': 'Campus I',
  //   },
  //   {
  //     'Data de Cadastro': '12/07/2023',
  //     'Material': 'Carteira',
  //     'Identificação': '789012',
  //     'Local em que foi encontrado': 'Biblioteca',
  //     'Campus': 'Campus II',
  //   },
  // ];

  List<Perdido> informacoesFiltradas = [];

  void pesquisar(String termo) {
    if (termo.isEmpty) {
      setState(() {
        informacoesFiltradas.clear();
      });
    } else {
      setState(() {
        informacoesFiltradas = widget.list
            .where((dados) => dados.toMap().values.any((value) {
                  print(value);
                  return value
                      .toString()
                      .toLowerCase()
                      .contains(termo.toLowerCase());
                }))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(shouldPopOnLogoPressed: true),
      body: Background(
        components: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(
                  16.0, 32.0, 16.0, 16.0), // Adiciona margens nas bordas
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: myRed, // Cor de fundo azul claro
                borderRadius: BorderRadius.circular(10.0), // Borda arredondada
              ),
              child: const Text(
                'OBS: Horário para retirada de achados e perdidos: \nVigilância: 8h30 às 17h30 de segunda à sexta-feira. \nLimeira Campus I - SAR/Central de Atendimentos: 07h às 19h excetio feriados.\nLimeira Campus II - SAR/Central de Atendimentos: 07h às 19h exceto feriados.',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      16.0), // Adiciona espaçamento horizontal na barra de pesquisa
              child: TextFormField(
                onChanged:
                    pesquisar, // Chama a função pesquisar quando o texto da barra de pesquisa é alterado
                cursorColor: myGreen,
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  filled: true, // Preenche o fundo da barra de pesquisa
                  fillColor: myWhite, // Cor de fundo branca
                  prefixIcon: Icon(Icons.search, color: myGreen),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: myGreen,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Aumenta o raio da borda
                      borderSide: BorderSide.none),
                ),
                // Aqui você pode adicionar lógica para tratar a pesquisa
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: informacoesFiltradas.length,
                itemBuilder: (context, index) {
                  var dados = informacoesFiltradas[index];
                  return ItemContainer(dados);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

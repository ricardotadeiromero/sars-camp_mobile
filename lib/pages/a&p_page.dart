import 'package:TCC/configs/style.dart';
import 'package:flutter/material.dart';
import 'package:TCC/pages/componentes/background.dart';

class AchaPerdi extends StatefulWidget {
  const AchaPerdi({super.key});

  @override
  State<AchaPerdi> createState() => _AchaPerdiState();
}

class _AchaPerdiState extends State<AchaPerdi> {
  List<Map<String, String>> dadosDoBanco = [
    {
      'Data de Cadastro': '10/07/2023',
      'Material': 'Chave',
      'Identificação': '123456',
      'Local em que foi encontrado': 'Sala 101',
      'Campus': 'Campus I',
    },
    {
      'Data de Cadastro': '12/07/2023',
      'Material': 'Carteira',
      'Identificação': '789012',
      'Local em que foi encontrado': 'Biblioteca',
      'Campus': 'Campus II',
    },
  ];

  List<Map<String, String>> informacoesFiltradas = [];

  void pesquisar(String termo) {
    if (termo.isEmpty) {
      setState(() {
        informacoesFiltradas.clear();
      });
    } else {
      setState(() {
        informacoesFiltradas = dadosDoBanco
            .where((dados) => dados.values.any(
                (value) => value.toLowerCase().contains(termo.toLowerCase())))
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
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: myWhite, // Cor de fundo branca
                      borderRadius:
                          BorderRadius.circular(10.0), // Borda arredondada
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var info in dados.keys)
                          Text(
                            '$info: ${dados[info]}',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

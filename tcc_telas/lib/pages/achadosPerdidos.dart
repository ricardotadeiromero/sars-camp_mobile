import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Componentes/Background.dart';

class achadosperdidos extends StatefulWidget {
  const achadosperdidos({super.key});

  @override
  State<achadosperdidos> createState() => _achadosperdidosState();
}

class _achadosperdidosState extends State<achadosperdidos> {
  bool tabelaVisivel = false;
  DateTime? _selectedDate;
  List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];
  final _formKey = GlobalKey<FormState>();
  String? _selectedDropdownItem;
  String _name = '';
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color verde = Color(0xFF0A6066);
    Color vermelho = Color(0xFFA12E2F);

    return Scaffold(
        appBar: const MyAppBar(shouldPopOnLogoPressed: true),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: verde,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15, top: 10, left: 10),
                width: 70,
                height: 70,
                child: Image.asset('image/achados-e-perdidos.png'),
              ),
              Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Text(
                    'Achados & perdidos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )),
            ],
          ),
          Positioned(
              top: 110,
              left: 10,
              right: 10,
              child: Container(
                  width: 500,
                  height: 600,
                  decoration: BoxDecoration(
                    color: vermelho,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data da Perda:',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                ).then((selectedDate) {
                                  setState(() {
                                    _selectedDate = selectedDate;
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 6), // Ajuste os valores de padding conforme desejado
                                minimumSize: Size(100, 2), // Ajuste o valor de minimumSize conforme desejado
                                //constraints: BoxConstraints.tightFor(width: 200, height: 60), // Ajuste os valores de width e height conforme desejado 
                              ),
                              child: Text(
                                _selectedDate == null
                                    ? 'Selecionar data'
                                    : DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate!),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Material:',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: DropdownButton<String>(
                                  value: _selectedDropdownItem,
                                  items:
                                      _dropdownItems.map((String dropdownItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropdownItem,
                                      child: Text(dropdownItem),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedDropdownItem = selectedValue!;
                                    });
                                  },
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  icon: Icon(Icons.arrow_drop_down),
                                  
                                  iconSize: 33,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Local da perda',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 131,
                              height: 38,
                              child: TextField(
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Digite aqui',
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _formKey.currentState?.reset();
                                      setState(() {
                                        _selectedDropdownItem = null;
                                        _selectedDate = null;
                                        _name = '';
                                        _textEditingController.clear();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0XFF919DAE),
                                      onPrimary: Colors.black,
                                    ),
                                    child: Text(
                                      'Limpar',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(Icons.search),
                                    color: Colors.white,
                                    iconSize:
                                        40, // Define o tamanho do ícone como 30 pixels
                                    onPressed: () {
                                      setState(() {
                                        tabelaVisivel = !tabelaVisivel;
                                      });
                                    },
                                  )

                                  /*ElevatedButton(
                              onPressed: () {
                                setState(() {
                        z          tabelaVisivel = !tabelaVisivel;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),*/
                                ]),
                          ],
                        ),
                        Visibility(
                          visible: tabelaVisivel,
                          child: SizedBox(height: 20),
                        ),
                        Visibility(
                          visible: tabelaVisivel,
                          child: DataTable(
                            key: UniqueKey(),
                            headingRowColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              return verde; // Use the default value.
                            }),

                            columns: [
                              DataColumn(
                                label: Text(
                                  'Coluna',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),  
                              ),
                            DataColumn(label: Text('Coluna2'),)
                            ],

                           rows: [
                            DataRow(cells: [
 
                              DataCell(
                                Text('text'),
                                ),

                              DataCell(
                                Text('text'),
                                ),                             
                            ])
                           ],
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
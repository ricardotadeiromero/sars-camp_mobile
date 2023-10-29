import 'package:TCC/configs/style.dart';
import 'package:TCC/model/perdido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemContainer extends StatelessWidget {
  final Perdido item;
  const ItemContainer(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: myWhite, // Cor de fundo branca
        borderRadius: BorderRadius.circular(10.0), // Borda arredondada
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data de cadastro: ${DateFormat("dd/MM/yyyy").format(item.data)}',
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          Text(
            'Material: ${item.material}',
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          Text(
            'Identificação: ${item.id}',
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          Text(
            'Local que foi encontrado: ${item.local}',
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          Text(
            item.campus == 1 ? 'Campus: Campus I' : 'Campus: Campus II',
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

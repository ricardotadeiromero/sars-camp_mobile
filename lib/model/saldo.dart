class Saldo {
  String _name;
  double _saldo;

  Saldo(this._name, this._saldo);

  String get name => _name;
  double get saldo => _saldo;

  // Método para converter a instância para um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'saldo': _saldo,
    };
  }

  // Método estático para criar uma instância da classe a partir de um mapa
  static Saldo fromMap(Map<String, dynamic> map) {
    return Saldo(map['name'], map['saldo']);
  }
}

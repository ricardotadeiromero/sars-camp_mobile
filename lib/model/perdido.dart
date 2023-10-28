class Perdido {
  int _id;
  String _material;
  String _local;
  DateTime _data;

  int get id => this._id;

  set id(int value) => this._id = value;

  get material => this._material;

  set material(value) => this._material = value;

  get local => this._local;

  set local(value) => this._local = value;

  get data => this._data;

  set data(value) => this._data = value;

  Perdido(this._id, this._material, this._local, this._data);

  factory Perdido.fromMap(dynamic obj) {
    return Perdido(
        obj['id'], obj['material'], obj['local'], DateTime.parse(obj['data']));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "material": material,
      "local": local,
      "data": data.toIso8601String(),
    };
  }
}

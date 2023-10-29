class Perdido {
  int _id;
  String _material;
  String _local;
  int _campus;
  int get campus => this._campus;

  set campus(int value) => this._campus = value;
  DateTime _data;

  int get id => this._id;

  set id(int value) => this._id = value;

  get material => this._material;

  set material(value) => this._material = value;

  get local => this._local;

  set local(value) => this._local = value;

  get data => this._data;

  set data(value) => this._data = value;

  Perdido(this._id, this._material, this._campus, this._local, this._data);

  factory Perdido.fromMap(dynamic obj) {
    return Perdido(obj['id'], obj['material'], obj['campus'], obj['local'],
        DateTime.parse(obj['data']));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "material": material,
      "local": local,
      "campus": campus,
      "data": data.toIso8601String(),
    };
  }
}

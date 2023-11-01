class Aluno {
  String _ra;
  String _password;

  Aluno(this._ra, this._password);

  String get ra => this._ra;

  set ra(String value) => this._ra = value;

  get password => this._password;

  set password(value) => this._password = value;

  Map<String, dynamic> toMap() {
    return {
      "ra": ra,
      "password": password,
    };
  }

  factory Aluno.fromMap(dynamic map) {
    return Aluno(map["ra"], map["password"]);
  }
}

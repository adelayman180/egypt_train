class Train {
  String _id;
  String _from;
  String _to;
  String _go;
  String _arrive;
  String _time;
  String _speed;
  String _level;
  String _stopin;
  bool _visible;

  Train.fromDB(Map<String, dynamic> map) {
    _id = map['id'];
    _from = map['trainFrom'];
    _to = map['trainTO'];
    _go = map['go'];
    _arrive = map['arrive'];
    _time = map['time'];
    _speed = map['speed'];
    _level = map['level'];
    _stopin = map['stopin'];
  }

  String get id => _id;
  String get from => _from;
  String get to => _to;
  String get go => _go;
  String get arrive => _arrive;
  String get time => _time;
  String get speed => _speed;
  String get level => _level;
  String get stopin => _stopin;
  bool get visible => _visible ?? false;

  set visible(vis) => _visible = vis;
}

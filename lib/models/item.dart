class Item {
  int? _id;
  String? _name;
  int? _price;
  int? _stock;
  String? _kodeBarang;

  int get id => _id!;

  String get name => _name!;
  set name(String value) => _name = value;

  int get price => _price!;
  set price(value) => _price = value;

  int get stock => _stock!;
  set stock(int value) => _stock = value;

  String get kodeBarang => _kodeBarang!;
  set kodeBarang(String value) => _kodeBarang = value;

  //konstruktor versi 1
  Item(
    this._name,
    this._price,
    this._stock,
    this._kodeBarang,
  );

  //konstrktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _price = map['price'];
    _stock = map['stock'];
    _kodeBarang = map['kodeBarang'];
  }

  //konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = name;
    map['price'] = price;
    map['stock'] = stock;
    map['kodeBarang'] = kodeBarang;
    return map;
  }
}
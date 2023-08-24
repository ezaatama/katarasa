class Milk {
  final int id;
  bool value;
  final String tittle;

  Milk({required this.id, this.value = false, required this.tittle});
}

String hasMilk = 'Dairy';

List<Milk> milk = [
  Milk(id: 1, value: false, tittle: 'Dairy'),
  Milk(id: 2, value: false, tittle: 'Almond'),
  Milk(id: 3, value: false, tittle: 'Oat'),
];

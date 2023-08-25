class Variant {
  final int id;
  bool selected;
  final String tittle;

  Variant({required this.id, this.selected = false, required this.tittle});
}

String hasTittle = 'Ice';

List<Variant> variant = [
  Variant(id: 1, selected: false, tittle: "Ice"),
  Variant(id: 2, selected: false, tittle: "Hot"),
];

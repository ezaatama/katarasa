class Ices {
  final int id;
  bool value;
  final String tittle;

  Ices({required this.id, this.value = false, required this.tittle});
}

String hasIces = 'Normal';

List<Ices> ices = [
  Ices(id: 1, value: false, tittle: 'Normal'),
  Ices(id: 2, value: false, tittle: 'Less'),
];

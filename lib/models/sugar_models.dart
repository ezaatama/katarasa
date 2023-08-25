class Sugar {
  final int id;
  bool value;
  final String tittle;

  Sugar({required this.id, this.value = false, required this.tittle});
}

String hasSugar = "Normal";

List<Sugar> sugars = [
  Sugar(id: 1, value: false, tittle: 'Normal'),
  Sugar(id: 2, value: false, tittle: 'Less'),
];

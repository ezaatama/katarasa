class TempSize {
  final int id;
  bool value;
  final String tittle;

  TempSize({required this.id, this.value = false, required this.tittle});
}

String hasTemp = "Regular";

List<TempSize> sizes = [
  TempSize(id: 1, value: false, tittle: "Regular"),
  TempSize(id: 2, value: false, tittle: "Medium"),
  TempSize(id: 3, value: false, tittle: "Large"),
];

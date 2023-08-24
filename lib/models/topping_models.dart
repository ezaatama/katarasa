class Topping {
  final int id;
  bool value;
  final String tittle;

  Topping({required this.id, this.value = false, required this.tittle});
}

String hasTopping = "Boba";

List<Topping> topping = [
  Topping(id: 1, value: false, tittle: 'Boba'),
  Topping(id: 2, value: false, tittle: 'Grass Jelly'),
  Topping(id: 3, value: false, tittle: 'Espresso'),
];

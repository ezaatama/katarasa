class Been {
  final int id;
  bool selected;
  final String tittle;

  Been({required this.id, this.selected = false, required this.tittle});
}

String hasTittle = 'Dark';

List<Been> beenPreferences = [
  Been(id: 1, selected: false, tittle: "Dark"),
  Been(id: 2, selected: false, tittle: "Decaf"),
  Been(id: 3, selected: false, tittle: "Light Roast"),
  Been(id: 4, selected: false, tittle: "Medium"),
];

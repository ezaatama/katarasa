class TempSize {
  final int id;
  bool value;
  final String tittle;

  TempSize({required this.id, this.value = false, required this.tittle});
}

String hasTemp = "Iced";

List<TempSize> tempSizes = [
  TempSize(id: 1, value: false, tittle: "Iced"),
  TempSize(id: 2, value: false, tittle: "Hot/Tail"),
  TempSize(id: 3, value: false, tittle: "Hot/Short"),
  TempSize(id: 4, value: false, tittle: "Iced + sea salt cream"),
  TempSize(id: 5, value: false, tittle: "Iced + coffee jelly"),
];

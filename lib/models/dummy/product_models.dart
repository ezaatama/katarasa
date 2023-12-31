import 'package:katarasa/models/dummy/variant_models.dart';
import 'package:katarasa/models/dummy/ice_models.dart';
import 'package:katarasa/models/dummy/sizes_models.dart';
import 'package:katarasa/models/dummy/sugar_models.dart';

class ProductModels {
  final String id;
  final String star;
  final String image;
  final String title;
  final String subtitle;
  final int price;
  final int? discount;
  final String ingredient;
  final String category;
  bool isFavorite;
  final Variant? variant;
  final TempSize? tempSize;
  final Ices? ice;
  final Sugar? sugar;

  ProductModels(
      {required this.id,
      required this.star,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.price,
      this.discount,
      required this.ingredient,
      required this.category,
      this.isFavorite = false,
      this.variant,
      this.tempSize,
      this.ice,
      this.sugar});

  void toggleStatus() {
    isFavorite = !isFavorite;
  }
}

final List<ProductModels> products = [
  ProductModels(
      id: 'P1',
      star: '4,2',
      image: 'assets/images/Moccacino.jpg',
      title: 'Moccacino',
      subtitle: 'coffee',
      price: 20000,
      discount: 18000,
      ingredient: 'Double Rissetro, Chocollate Powder, Fresh Milk',
      category: "Coffee"),
  ProductModels(
      id: 'P2',
      star: '4,2',
      image: 'assets/images/HazelnutLatte.jpg',
      title: 'Hazelnut Latte',
      subtitle: 'coffee',
      price: 25000,
      discount: null,
      ingredient: 'Double Ristretto, Chocolate Powder, Fresh Milk',
      category: "Coffee"),
  ProductModels(
      id: 'P3',
      star: '4,2',
      image: 'assets/images/Macchiato.jpeg',
      title: 'Macchiato',
      subtitle: 'non-coffee',
      price: 32000,
      discount: null,
      ingredient: 'Single Ristretto with fresh milk',
      category: "Coffee"),
  ProductModels(
      id: 'P4',
      star: '4,2',
      image: 'assets/images/KopiSusu.jpeg',
      title: 'Kopi Susu',
      subtitle: 'non-coffee',
      price: 15000,
      discount: 13000,
      ingredient: 'Espresso + Brown Sugar + Fresh Milk + Creamer',
      category: "Coffee"),
  ProductModels(
      id: 'P5',
      star: '4,2',
      image: 'assets/images/CaramelMacchiato.jpeg',
      title: 'Caramel Macchiato',
      subtitle: 'coffee',
      price: 24000,
      discount: null,
      ingredient: 'Single Ristretto with Fresh Milk and Palm Sugar',
      category: "Coffee"),
  ProductModels(
      id: 'P6',
      star: '4,2',
      image: 'assets/images/Latte.jpeg',
      title: 'Latte',
      subtitle: 'coffee',
      price: 18000,
      discount: null,
      ingredient: 'Double Espresso with Freshmilk',
      category: "Coffee"),
  ProductModels(
      id: 'P7',
      star: '4,2',
      image: 'assets/images/Macchiato.jpeg',
      title: 'Moccachino',
      subtitle: 'non-coffee',
      price: 32000,
      discount: 30000,
      ingredient: 'Single Ristretto with fresh milk',
      category: "Coffee"),
  ProductModels(
      id: 'P8',
      star: '4,2',
      image: 'assets/images/KopiSusu.jpeg',
      title: 'Kopi Kata Rasa',
      subtitle: 'non-coffee',
      price: 15000,
      discount: 13000,
      ingredient: 'Espresso + Brown Sugar + Fresh Milk + Creamer',
      category: "Coffee"),
];

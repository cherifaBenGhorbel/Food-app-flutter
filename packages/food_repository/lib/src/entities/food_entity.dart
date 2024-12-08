
import '../models/macros.dart';
import 'entities.dart';

class FoodEntity {
  String foodId;
  String picture;
  bool isVeg;
  int spicy;
  String name;
  String description;
  int price;
  int discount;
  Macros macros;

  FoodEntity({
    required this.foodId,
    required this.picture,
    required this.isVeg,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  Map<String, Object?> toDocument() {
    return {
      'foodId': foodId,
      'picture': picture,
      'isVeg': isVeg,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toEntity().toDocument(),
    };
  }

  static FoodEntity fromDocument(Map<String, dynamic> doc) {
    return FoodEntity(
      foodId: doc['foodId'] ?? '', // Default to empty string
      picture: doc['picture'] ?? '', // Default to empty picture
      isVeg: doc['isVeg'] ?? false, // Default to false
      spicy: doc['spicy'] ?? 1, // Default to 1 (mild)
      name: doc['name'] ?? 'Unnamed Food', // Default name
      description: doc['description'] ?? 'No description available.',
      price: doc['price'] ?? 0, // Default to $0
      discount: doc['discount'] ?? 0, // Default to 0% discount
      macros: doc['macros'] != null
          ? Macros.fromEntity(MacrosEntity.fromDocument(doc['macros']))
          : Macros(calories: 0, proteins: 0, fat: 0, carbs: 0), // Default macros
    );
  }

}
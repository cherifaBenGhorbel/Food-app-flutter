import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../food_repository.dart';

class FirebaseFoodRepo implements FoodRepo {
  final foodCollection = FirebaseFirestore.instance.collection('foods');

  @override
  Future<List<Food>> getFoods() async {
    try {
      return await foodCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Food.fromEntity(FoodEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createFoods(Food food) async {
    try{
      return await foodCollection
          .doc(food.foodId)
          .set(food.toEntity().toDocument());
    }catch(e) {
      log(e.toString());
      rethrow;
    }
  }
}
import '../food_repository.dart';

abstract class FoodRepo {
  Future<List<Food>> getFoods();

}
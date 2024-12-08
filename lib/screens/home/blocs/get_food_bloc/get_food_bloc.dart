import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_repository/food_repository.dart';

part 'get_food_event.dart';
part 'get_food_state.dart';

class GetFoodBloc extends Bloc<GetFoodEvent, GetFoodState> {
  final FoodRepo foodRepository;
  GetFoodBloc(this.foodRepository) : super(GetFoodInitial()){
    on<GetFoods>((event, emit) async {
      emit(GetFoodLoading());
      try {
        final foods = await foodRepository.getFoods();
        for (var food in foods) {
          print(food.toEntity().toDocument()); // Log data to check for null fields
        }
        emit(GetFoodSuccess(foods));
      } catch (e) {
        print(e); // Log error
        emit(GetFoodFailure());
      }
    });

  }
}

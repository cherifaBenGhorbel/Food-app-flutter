import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_repository/food_repository.dart';

part 'get_cart_event.dart';
part 'get_cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      final currentState = state;
      if (currentState is CartLoaded) {
        try {
          emit(CartLoaded(items: List.from(currentState.items)..add(event.item)));
        } catch (_) {
          emit(CartError());
        }
      } else {
        try {
          emit(CartLoaded(items: [event.item]));
        } catch (_) {
          emit(CartError());
        }
      }
    });

    on<RemoveFromCart>((event, emit) {
      final currentState = state;
      if (currentState is CartLoaded) {
        try {
          emit(CartLoaded(items: List.from(currentState.items)..remove(event.item)));
        } catch (_) {
          emit(CartError());
        }
      }
    });
  }
}


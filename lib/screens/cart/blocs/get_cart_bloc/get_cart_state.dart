part of 'get_cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Food> items;

  const CartLoaded({this.items = const []});

  @override
  List<Object> get props => [items];
}

class CartError extends CartState {}


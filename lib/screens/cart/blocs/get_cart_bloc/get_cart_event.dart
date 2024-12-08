part of 'get_cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Food item;

  const AddToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final Food item;

  const RemoveFromCart(this.item);

  @override
  List<Object> get props => [item];
}


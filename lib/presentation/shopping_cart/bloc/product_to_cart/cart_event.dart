import 'package:equatable/equatable.dart';
import 'package:newzen/models/product_model.dart';

abstract class CartEvent extends Equatable {}

class AddToCart extends CartEvent {
  final ProductModel product;
  AddToCart({required this.product});
  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final ProductModel product;
  RemoveFromCart({required this.product});

  @override
  List<Object?> get props => [product];
}

class IncreaseProductQuantity extends CartEvent {
  final int id;

  IncreaseProductQuantity({required this.id});

  @override
  List<Object?> get props => [id];
}

class DecreaseProductQuantity extends CartEvent {
  final int id;
  DecreaseProductQuantity({required this.id});

  @override
  List<Object?> get props => [id];
}

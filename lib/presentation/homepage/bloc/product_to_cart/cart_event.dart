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

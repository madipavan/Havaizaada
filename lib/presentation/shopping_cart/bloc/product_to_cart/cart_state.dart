import 'package:equatable/equatable.dart';
import 'package:newzen/models/product_model.dart';

class CartState extends Equatable {
  final List<ProductModel> cartProducts;
  final double totalPrice;
  final int totalQuantity;
  const CartState({
    this.cartProducts = const [],
    this.totalPrice = 0.0,
    this.totalQuantity = 0,
  });
  CartState copyWith({List<ProductModel>? cartProducts}) {
    // Calculating the total price based on the updated quantity
    final updatedTotal = cartProducts!.fold(
      0.0,
      (sum, item) => sum + (item.newPrice * item.quantity),
    );
    // Calculating the total  updated quantity
    final updatedTotalQuantity = cartProducts.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
    return CartState(
        cartProducts: cartProducts,
        totalPrice: updatedTotal,
        totalQuantity: updatedTotalQuantity);
  }

  @override
  List<Object?> get props => [cartProducts];
}

class CartUpdated extends CartState {
  const CartUpdated({required super.cartProducts});
  @override
  List<Object?> get props => [cartProducts];
}

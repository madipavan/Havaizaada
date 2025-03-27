import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/models/product_model.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_event.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_addProductTocart);
    on<IncreaseProductQuantity>(_increaseProductQuantity);
    on<DecreaseProductQuantity>(_decreaseProductQuantity);
    on<RemoveFromCart>(_removeFromCart);
  }
  //add product to cart
  void _addProductTocart(AddToCart event, Emitter<CartState> emit) {
    final updatedCart = List<ProductModel>.from(state.cartProducts);
    updatedCart.add(event.product);
    emit(state.copyWith(cartProducts: updatedCart));
  }

  //increase product quantity
  void _increaseProductQuantity(
      IncreaseProductQuantity event, Emitter<CartState> emit) {
    List<ProductModel> newList = state.cartProducts.map((ProductModel item) {
      if (item.id == event.id) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList(); //increasing quantity of particular item
    emit(state.copyWith(cartProducts: List.from(newList)));
  }

  //decrease product quantity
  void _decreaseProductQuantity(
      DecreaseProductQuantity event, Emitter<CartState> emit) {
    List<ProductModel> newList = state.cartProducts.map((ProductModel product) {
      if (product.id == event.id) {
        return product.copyWith(
            quantity: product.quantity > 1 ? product.quantity - 1 : 1);
      }
      return product;
    }).toList(); //increasing quantity of particular item
    emit(state.copyWith(cartProducts: List.from(newList)));
  }

  //remove product from cart
  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedList = List<ProductModel>.from(state.cartProducts)
      ..removeWhere((product) => product.id == event.product.id);

    emit(state.copyWith(cartProducts: updatedList));
  }
}

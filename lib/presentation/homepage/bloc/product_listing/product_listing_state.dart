import 'package:equatable/equatable.dart';
import 'package:newzen/models/product_model.dart';

class ProductListingState extends Equatable {
  final List<ProductModel> productList; //main product list
  const ProductListingState({this.productList = const []});

  ProductListingState copyWith({List<ProductModel>? productList}) {
    return ProductListingState(productList: productList ?? this.productList);
  }

  @override
  List<Object?> get props => [productList];
}

class ProductListLoading extends ProductListingState {
  const ProductListLoading({required super.productList});
}

class ProductListLoaded extends ProductListingState {
  final bool notHaveMoreData;
  const ProductListLoaded(
      {required super.productList, required this.notHaveMoreData});
}

class ProductListError extends ProductListingState {
  final String errorMsg;
  const ProductListError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

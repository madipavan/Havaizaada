import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/models/product_model.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_state.dart';
import 'package:newzen/service/products_service/products_api_service.dart';

import 'product_listing_event.dart';

class ProductListingBloc
    extends Bloc<ProductListingEvent, ProductListingState> {
  final ProductsApiService productApiService;

  List<ProductModel> productsList = []; //list of products
  int skip = 0; //to skipp the already fetched data
  final int limit = 10; //number of products to fetch
  bool _isFetching = false; //checking if already event is fetching data

  ProductListingBloc(this.productApiService) : super(ProductListingState()) {
    on<FetchProductList>(_fetchProductList);
  }

  void _fetchProductList(
      FetchProductList event, Emitter<ProductListingState> emit) async {
    if (_isFetching) return; //if its already fetching data it will return
    final oldProductList = state.productList; //saving state of old list
    _isFetching = true;

    try {
      final data =
          await productApiService.fetchProducts(skip: skip, limit: limit);
      productsList = data.map((json) => ProductModel.fromJson(json)).toList();

      final newList = [...oldProductList, ...productsList];

      bool notHaveMoreData = productsList.length !=
          limit; //becoz if its has more data it will be == to 10

      if (!notHaveMoreData) {
        skip += limit; //skips the next 10 products
      }

      emit(ProductListLoaded(
          productList: newList, notHaveMoreData: notHaveMoreData));
    } catch (e) {
      emit(ProductListError(errorMsg: e.toString()));
    }
    _isFetching = false;
  }
}

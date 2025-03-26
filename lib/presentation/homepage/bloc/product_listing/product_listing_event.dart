import 'package:equatable/equatable.dart';

abstract class ProductListingEvent extends Equatable {}

class FetchProductList extends ProductListingEvent {
  @override
  List<Object?> get props => [];
}

import 'package:dio/dio.dart';

class ProductsApiService {
  final dio = Dio();
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Map<String, dynamic>>> fetchProducts(
      {int limit = 10, int skip = 0}) async {
    final response = await dio.get(baseUrl, queryParameters: {
      'limit': limit,
      'skip': skip,
    });
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data['products']);
    } else {
      throw Exception("Failed to fetch products");
    }
  }
}

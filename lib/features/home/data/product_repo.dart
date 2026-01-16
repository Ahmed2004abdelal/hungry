import 'package:dio/dio.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import 'product_model.dart';

class ProductRepo {
  ApiService _apiService = ApiService();

  /// get products
  Future<List<ProductModel>> getproduct() async {
    try {
      final Response = await _apiService.get('products/');
      return (Response['data'] as List)
          .map((e) => ProductModel.fromjson(e))
          .toList();
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// search

  /// category
}

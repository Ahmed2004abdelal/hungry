import 'package:dio/dio.dart';

import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import 'cart_model.dart';

class CartRepo {
  ApiService _apiService = ApiService();
  // PrefHelpers prefHelpers = PrefHelpers();

  ///add to cart
  Future<void> addtoCart(cartRequestModel cartData) async {
    try {
      final res = await _apiService.post("cart/add", cartData.toJson());
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///get Cart Data
  Future<GetCartResponse> getCartData() async {
    try {
      final res = await _apiService.get("cart");
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }
      return GetCartResponse.fromjson(res);
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///remove item from cart
  Future<void> removeFromCart(int itemId) async {
    try {
      final res = await _apiService.delete('cart/remove/${itemId}', {});
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

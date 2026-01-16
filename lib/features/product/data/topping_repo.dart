import 'package:dio/dio.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import 'topping_model.dart';

class ToppingRepo {
  final ApiService _apiService = ApiService();

  ///get topping
  Future<List<ToppingModel>?> getTopping() async {
    try {
      final res = await _apiService.get('toppings');
      return (res['data'] as List)
          .map((e) => ToppingModel.fromjson(e))
          .toList();
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///get side_options
  Future<List<ToppingModel>?> getSideoptions() async {
    try {
      final res = await _apiService.get('side-options');
      return (res['data'] as List)
          .map((e) => ToppingModel.fromjson(e))
          .toList();
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

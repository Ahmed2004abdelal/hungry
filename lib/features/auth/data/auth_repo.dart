import 'package:dio/dio.dart';

import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/pref_helpers.dart';
import 'user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? _currentUser;

  /// login
  Future<UserModel?> login(String email, String pass) async {
    try {
      final Response = await apiService.post('login', {
        "email": email,
        "password": pass,
      });

      if (Response is ApiError) {
        throw Response;
      }

      if (Response is Map<String, dynamic>) {
        // final msg = Response['message'];
        // final code = Response['code'];
        final data = Response['data'];

        // if (code != 200 && code != 201) {
        //   throw ApiError(message: msg ?? "unkonwn error");
        // }
        final user = UserModel.fromjson(data);
        if (user.token != null) {
          await PrefHelpers.saveToken(user.token!);
        }

        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "unkonwn error2");
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// signup
  ///
  ///
  ///

  Future<UserModel?> signup(
    String name,
    String email,
    String pass,
    String confPass,
  ) async {
    try {
      final Response = await apiService.post("register", {
        "name": name,
        "email": email,
        "password": pass,
        "password_confirmation": confPass,
      });

      if (Response is ApiError) {
        throw Response;
      }
      if (Response is Map<String, dynamic>) {
        final msg = Response['message'];
        final code = Response['code'];
        final data = Response['data'];

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? "unkonwn error");
        }
        final user = UserModel.fromjson(data);

        if (user.token != null) {
          await PrefHelpers.saveToken(user.token!);
        }

        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "unkonwn error");
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// get profile data
  ///
  ///
  ///
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelpers.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final Response = await apiService.get("profile");

      if (Response == null) {
        throw ApiError(message: "Empty response from server");
      }

      if (Response is ApiError) {
        throw Response;
      }

      if (Response is! Map<String, dynamic> || Response['data'] == null) {
        throw ApiError(message: "Invalid response format");
      }

      final user = UserModel.fromjson(Response['data']);
      _currentUser = user;
      return user;
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// update profile
  ///
  ///
  ///
  // Future<UserModel?> updateProfileData({
  //   required String name,
  //   String? email,
  //   String? oldEmail,
  //   required String address,
  //   String? visa,
  //   String? imagePath,
  // }) async {
  //   try {
  //     final formData = FormData.fromMap({
  //       'name': name,
  //       if(email != null && email.isNotEmpty)'email': email,
  //       'address': address,
  //       if (visa != null && visa.isNotEmpty) 'Visa': visa,
  //       if (imagePath != null &&
  //           imagePath.isNotEmpty &&
  //           !imagePath.startsWith('http'))
  //         'image': await MultipartFile.fromFile(
  //           imagePath,
  //           filename: 'profile.jpg',
  //         ),
  //     });
  //     final response = await apiService.post('/update-profile', formData);
  //     if (response is ApiError) {
  //       throw response;
  //     }

  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? oldEmail, // <-- أضفنا ده علشان نعرف الإيميل القديم
    String? visa,
    String? imagePath,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (imagePath != null &&
            imagePath.isNotEmpty &&
            !imagePath.startsWith('http'))
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),
      };

      if (oldEmail == null || oldEmail != email) {
        data['email'] = email;
      }

      final formData = FormData.fromMap(data);

      final response = await apiService.post('/update-profile', formData);

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final updateUser = UserModel.fromjson(data);
        _currentUser = updateUser;
        return updateUser;
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// logout
  ///
  ///
  ///
  Future<void> logout() async {
    await apiService.delete('/logout', {});

    await PrefHelpers.clearToken();
    _currentUser = null;
    isGuest = true;
  }

  /// auto login
  ///
  ///
  ///
  Future<UserModel?> autologin() async {
    final token = await PrefHelpers.getToken();
    if (token == null || token == 'guest') {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      return user;
    } catch (_) {
      await PrefHelpers.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  /// continue as a guest
  ///
  ///
  ///
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelpers.saveToken("guest");
  }

  UserModel? get currentuser => _currentUser;
  bool get isLoggedin => !isGuest && _currentUser != null;
}

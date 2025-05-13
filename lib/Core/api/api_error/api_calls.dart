import 'package:dio/dio.dart';
import 'package:serious_todo/Constants/api_constants.dart';

import 'dio_exception.dart';

class ApiCalls {
  //   get method
  getData({required String endpoint}) async {
    try {
      // initializing dio
      final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.apiBaseUrl));

      // getting response from endpoint
      final response = await dio.get(endpoint);

      // checking server status
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 404) {
        return "Endpoint not found";
      } else {
        return "There is something wrong with Server";
      }
    } on DioException catch (e) {
      throw CustomDioException.fromDioError(e);
    }
  }
}

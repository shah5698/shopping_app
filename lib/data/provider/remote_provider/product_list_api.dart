import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '/utilities/constants/constants.dart';
import '/utilities/exception/exception_handler.dart';

class ProductsListApi {
  static Future<http.Response> getRawData() async {
    final http.Response response;
    try {
      response = await http.get(
        Uri.parse("$baseURL/products"),
      );
    } on TimeoutException {
      throw TimeoutException("Timed out");
    } on SocketException {
      throw NoInternetException("No Internet");
    } on HttpException {
      throw NoServiceFoundException("No Service Found");
    } on FormatException {
      throw InvalidFormatException("Invalid Data Format");
    } catch (e) {
      throw UnknownException(e.toString());
    }
    return response;
  }
}

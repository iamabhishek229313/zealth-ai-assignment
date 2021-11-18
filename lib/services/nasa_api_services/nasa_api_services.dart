import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zealth_ai_assign/models/pod_model.dart';

class NasaAPIServices {
  static final String _baseUrl = "https://api.nasa.gov/";
  static final String _endPoint = "planetary/apod";
  static final String _api_key = "rDzAqHQWg8ZBhjgnEfnuNUeNu3gUFqF4xWLkcEJC";

  Future<PODModel> getPOD(DateTime dateTime) async {
    PODModel responseJson;
    try {
      Uri url = Uri.parse(
          _baseUrl + _endPoint + "?date=${dateTime.year}-${dateTime.month}-${dateTime.day}" + "&api_key=$_api_key");
      final response = await http.get(url);
      responseJson = returnResponse(response);
    } catch (ex) {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  PODModel returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        PODModel podModel = PODModel.fromJson(jsonDecode(response.body));
        return podModel;
      case 400:
        throw Exception('Invalid Date Exception');
      default:
        throw Exception("Unknown Exception");
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stockaxis_flutter_app/services/network/api_client.dart';

typedef OnSuccessful = Function(String response);
typedef OnProgressed = Function();
typedef OnError = Function(String errorMessage);

class ApiWrapper {
  final OnSuccessful onSuccessful;
  final OnProgressed onProgressed;
  final OnError onError;
  final String urlBasic;

  ApiWrapper({
    required this.onSuccessful,
    required this.onProgressed,
    required this.onError,
    required this.urlBasic,
  });

  getDioResponse() async {
    try {
      onProgressed();
      ApiClient apiClient = ApiClient.defaultClient();

      // Add headers
      var headers = {
        'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9',
      };

      print('getDioResponse service call >>> $urlBasic');
      // Make the GET request with headers
      final response = await apiClient.dioClient?.get(
        urlBasic,
        options: Options(headers: headers),
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        var responseData = response?.data;

        if (responseData is Map || responseData is List) {
          // Directly pass JSON data if it's already parsed
          String jsonString = jsonEncode(responseData);
          print("Extracted JSON: $jsonString");
          onSuccessful(jsonString);
        } else if (responseData is String) {
          // If response is a raw string, attempt to extract JSON using regex
          RegExp jsonRegex = RegExp(r'(\{.*\}|\[.*\])', dotAll: true);
          Match? match = jsonRegex.firstMatch(responseData);

          if (match != null) {
            String jsonString = match.group(1)!;
            print("Extracted JSON from String: $jsonString");
            onSuccessful(jsonString);
          } else {
            throw Exception("No valid JSON found in response");
          }
        } else {
          throw Exception(
              "Unexpected response type: ${responseData.runtimeType}");
        }
      } else {
        onError(response?.statusMessage.toString() ?? '');
      }
    } catch (e) {
      print('Error >>>>>  $e');
      onError('Error: $e');
    }
  }
}

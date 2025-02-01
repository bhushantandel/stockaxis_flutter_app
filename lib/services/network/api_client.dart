// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_conditional_assignment

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:stockaxis_flutter_app/services/network/url_constant.dart';

class ApiClient {
  Dio? dioClient;

  ApiClient.defaultClient({BaseOptions? baseOptions}) {
    if (baseOptions == null) {
      baseOptions = BaseOptions(
          baseUrl: UrlConstants.baseurl,
          connectTimeout: Duration(milliseconds: 60000),
          receiveTimeout: Duration(milliseconds: 60000));
    }
    dioClient = Dio(baseOptions);
    dioClient!.interceptors.add(LogInterceptor());

    dioClient?.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));

        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
  }
}

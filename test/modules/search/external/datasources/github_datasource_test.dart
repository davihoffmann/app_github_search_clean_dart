import 'dart:convert';

import 'package:app_github_search_clean_dart/modules/search/domain/errors/errors.dart';
import 'package:app_github_search_clean_dart/modules/search/external/datasource/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDataSource(dio);

  test("Deve retornar uma lista de ResultSearchModel", () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(githubResponse), statusCode: 200));

    final future = datasource.getSearch("davihoffmann");
    expect(future, completes);
  });

  test("Deve retornar um erro se o código não for 200", () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.getSearch("davihoffmann");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("Deve retornar uma Exception se tiver um erro no Dio", () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch("davihoffmann");
    expect(future, throwsA(isA<Exception>()));
  });
}

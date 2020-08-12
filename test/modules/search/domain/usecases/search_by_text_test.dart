import 'package:app_github_search_clean_dart/modules/search/domain/entities/result_search.dart';
import 'package:app_github_search_clean_dart/modules/search/domain/errors/errors.dart';
import 'package:app_github_search_clean_dart/modules/search/domain/repositories/search_repository.dart';
import 'package:app_github_search_clean_dart/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final useCase = SearchByTextImpl(repository);

  test('Deve retornar uma lista de ResulSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await useCase.call("davihoffmann");
    expect(result, isA<Right>());
    expect(result.getOrElse(() => null), isA<List<ResultSearch>>());
  });

  test('Deve retornar um Excpetion caso o texto seja inválido', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    var result = await useCase.call(null);
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    expect(result.getOrElse(() => null), null);

    result = await useCase.call("");
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    expect(result.getOrElse(() => null), null);
  });
}

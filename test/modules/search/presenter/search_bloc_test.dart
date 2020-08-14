import 'package:app_github_search_clean_dart/modules/search/domain/entities/result_search.dart';
import 'package:app_github_search_clean_dart/modules/search/domain/errors/errors.dart';
import 'package:app_github_search_clean_dart/modules/search/domain/usecases/search_by_text.dart';
import 'package:app_github_search_clean_dart/modules/search/presenter/search_bloc.dart';
import 'package:app_github_search_clean_dart/modules/search/presenter/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test("Deve retornar os estados na ordem correta", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));

    bloc.add("davihoffmann");
  });

  test("Deve retornar um erro", () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));

    bloc.add("davihoffmann");
  });
}

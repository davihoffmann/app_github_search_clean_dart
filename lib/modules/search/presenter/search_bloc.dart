import 'package:app_github_search_clean_dart/modules/search/domain/usecases/search_by_text.dart';
import 'package:app_github_search_clean_dart/modules/search/presenter/states/state.dart';
import 'package:bloc/bloc.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
    yield SearchLoading();
    final result = await usecase.call(searchText);
    yield result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }
}

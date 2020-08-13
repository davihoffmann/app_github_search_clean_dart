import 'package:app_github_search_clean_dart/app_widget.dart';
import 'package:app_github_search_clean_dart/modules/search/domain/usecases/search_by_text.dart';
import 'package:app_github_search_clean_dart/modules/search/external/datasource/github_datasource.dart';
import 'package:app_github_search_clean_dart/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind((i) => SearchByTextImpl(i.get())),
        Bind((i) => SearchRepositoryImpl(i.get())),
        Bind((i) => GithubDataSource(i.get())),
      ];

  @override
  List<Router> get routers => throw UnimplementedError();

  @override
  Widget get bootstrap => AppWidget();
}

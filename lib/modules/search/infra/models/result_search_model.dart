import 'dart:convert';

import 'package:app_github_search_clean_dart/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel({String avatarUrl, String login, String nodeId})
      : super(avatarUrl: avatarUrl, login: login, nodeId: nodeId);

  Map<String, dynamic> toMap() {
    return {
      'avatarUrl': avatarUrl,
      'login': login,
      'nodeId': nodeId,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      avatarUrl: map['avatar_url'],
      login: map['login'],
      nodeId: map['node_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResultSearchModel(avatarUrl: $avatarUrl, title: $login, content: $nodeId)';
}

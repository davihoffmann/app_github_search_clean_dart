import 'dart:convert';

import 'package:app_github_search_clean_dart/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String image;
  final String title;
  final String content;

  ResultSearchModel({
    this.image,
    this.title,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'content': content,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      image: map['image'],
      title: map['title'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResultSearchModel(image: $image, title: $title, content: $content)';
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../entity/post_entity.dart';

class PostItem extends PostEntity {
  const PostItem({
    required int id,
    required String title,
    required String body,
  }) : super(id: id, title: title, body: body);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostItem.fromMap(Map<String, dynamic> map) {
    return PostItem(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostItem.fromJson(String source) =>
      PostItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

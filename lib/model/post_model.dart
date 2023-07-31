// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostItem extends Equatable {
  final int id;
  final String title;
  final String body;

   PostItem({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [id, title, body];

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

  factory PostItem.fromJson(String source) => PostItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

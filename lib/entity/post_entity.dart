// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'post_entity.g.dart';

@HiveType(typeId: 0)
class PostEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;

  const PostEntity({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];

  @override
  String toString() => 'id: $id, title: $title, body: $body';

  PostEntity copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}

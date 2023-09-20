import 'package:caching_data_examples/data/shared_pref_cached_data.dart';
import 'package:caching_data_examples/entity/post_entity.dart';
import 'package:caching_data_examples/model/post_model.dart';
import 'package:dio/dio.dart';

class RemoteSource {
  final Dio _dio;

  final BaseLocalDataSource baseLocalDataSource;

  RemoteSource(this.baseLocalDataSource, this._dio);

  Future<PostEntity> fetchData() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/1');
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      } else {
        PostEntity post = PostItem.fromMap(response.data);
        baseLocalDataSource.saveInLocalBox<PostEntity>(
          data: post,
          expirationDuration: const Duration(days: 1),
          labelKey: '123',
        );
        return post;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}

import 'package:caching_data_examples/entity/post_entity.dart';

import '../data/remote_source.dart';
import '../data/shared_pref_cached_data.dart';

class RepositoryForSharedPrefWay {
  final RemoteSource remoteSource;
  final BaseLocalDataSource baseLocalDataSource;
  RepositoryForSharedPrefWay({
    required this.remoteSource,
    required this.baseLocalDataSource,
  });

  Future<PostEntity> getData() async {
    try {
      final PostEntity? localPost =
          await baseLocalDataSource.getFromLocalBox<PostEntity>(
        labelKey: '123',
      );
      if (localPost != null) {
        return localPost;
      } else {
        return await remoteSource.fetchData();
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<PostEntity> refreshData() async {
    return await remoteSource.fetchData();
  }
}

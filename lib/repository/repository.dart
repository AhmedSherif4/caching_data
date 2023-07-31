
import 'dart:convert';

import '../data/remote_source.dart';
import '../model/post_model.dart';
import '../data/shared_pref_cached_data.dart';


class RepositoryForSharedPrefWay {
  final RemoteSource remoteSource;
  final MySharedPreferences mySharedPreferences;
  RepositoryForSharedPrefWay({
    required this.remoteSource,
    required this.mySharedPreferences,
  });

  Future<List<PostItem>> getData() async {
    try {
      final String? jsonData = await mySharedPreferences.getDataIfNotExpired();
      if (jsonData != null) {
        return List<PostItem>.from(
          (jsonDecode(jsonData) as List).map(
            (post) => PostItem.fromMap(post),
          ),
        );
      } else {
        await remoteSource.fetchData();
        return getData();
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<PostItem>> refreshData() async {
    await remoteSource.fetchData();
    return getData();
  }
}

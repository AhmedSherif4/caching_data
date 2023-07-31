
import 'package:caching_data_examples/data/shared_pref_cached_data.dart';
import 'package:http/http.dart' as http;


class RemoteSource {
  final MySharedPreferences mySharedPreferences;

  RemoteSource(this.mySharedPreferences);

  Future<String> fetchData() async {
    print('fetchData');
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      } else {
        final isSaved = await mySharedPreferences.saveDataWithExpiration(
            response.body, const Duration(days: 10));
        if (isSaved) {
          return response.body;
        } else {
          throw Exception('Failed to save data');
        }
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}

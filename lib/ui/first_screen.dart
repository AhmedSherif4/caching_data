import 'package:caching_data_examples/data/remote_source.dart';
import 'package:caching_data_examples/data/shared_pref_cached_data.dart';
import 'package:caching_data_examples/ui/sec_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/post_model.dart';
import '../repository/repository.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final RepositoryForSharedPrefWay _repoClass2 = RepositoryForSharedPrefWay(
      remoteSource: RemoteSource(MySharedPreferences()),
      mySharedPreferences: MySharedPreferences());

  Future<List<PostItem>> posts() async =>
      await _repoClass2.getData().then((value) => value);

  @override
  void initState() {
    //_repoClass2.clearData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: posts(),
          builder: (futureContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              /*   ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'loading',
              ),
              duration: Duration(seconds: 3),
            ),
          ); */
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<PostItem> posts = snapshot.data!;
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].body),
                      leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SecScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    itemCount: posts.length,
                  ));
            }
          },
        ),
      ),
    );
  }
}

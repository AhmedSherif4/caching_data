import 'package:caching_data_examples/data/remote_source.dart';
import 'package:caching_data_examples/entity/post_entity.dart';
import 'package:caching_data_examples/ui/sec_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/shared_pref_cached_data.dart';
import '../repository/repository.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final RepositoryForSharedPrefWay _repoClass2 = RepositoryForSharedPrefWay(
      remoteSource: RemoteSource(BaseLocalDataSource(), Dio()),
      baseLocalDataSource: BaseLocalDataSource());

  Future<PostEntity> post() async =>
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
          future: post(),
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
              PostEntity posts = snapshot.data!;
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(posts.title),
                      subtitle: Text(posts.body),
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
                    itemCount: 1,
                  ));
            }
          },
        ),
      ),
    );
  }
}

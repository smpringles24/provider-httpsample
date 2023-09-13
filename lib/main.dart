// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart';
import 'post_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PostsProvider()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Use Example'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text("Get Request!"),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_tree_outlined),
              ),
              FutureBuilder(
                future: context.read<PostsProvider>().fetchAndSetPosts(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  } else {
                    return Text('Number of Posts: ${snapshot.data!.length}');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  var userId;
  var id;
  var title;
  var body;

  InfoContainer(
      {super.key,
      required this.userId,
      required this.id,
      required this.title,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('userId: ${userId.toString()}'),
          Text('id: ${id.toString()}'),
          Text('title: $title'),
          Text('body: $body'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hype_app/screens/home/index.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final httpLink = HttpLink(
      uri: 'http://localhost:8000/graphql/',
    ) as Link;

    final client = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: httpLink
      )
    );

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: Home()
        )
      )
    );
  }
}

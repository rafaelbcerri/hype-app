import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final httpLink = HttpLink(
      uri: 'http://localhost:8000/graphql/',
    );

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
          home: Scaffold(
            appBar: AppBar(title: Text("Things")),
            body: Things(),
          ),
        )
      )
    );
  }
}

class Things extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final getThings = """
      query getThings {
        things {
          text
        }
      }
    """;

    return Query(
      options: QueryOptions(
        document: getThings
      ),
      builder: (QueryResult result, { VoidCallback refetch }) {

        if (result.loading) {
          return Text('Carregando');
        }
        print(result.data);
        final things = result.data['things'];

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: things.length,
          itemBuilder: (context, i) {
            final thing = things[i];
            return Text(thing['text']);
          },
        );
      }
    );
  }
}

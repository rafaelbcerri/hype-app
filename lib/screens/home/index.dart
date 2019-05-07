import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hype_app/utils/api-query.dart';

class Home1 extends StatefulWidget {
  final things;

  Home1(this.things);

  @override
  Home1State createState() => Home1State(things);
}

class Home1State extends State<Home1> {
  final _listThings;

  Home1State(this._listThings);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16
        ),
        child: Column(children: <Widget>[
          Text(
            'Olá, Paulo Girardelli',
            style: TextStyle(
              color: Color.fromARGB(255, 18, 18, 18),
              fontFamily: 'Raleway',
              fontSize: 38
            )
          ),
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Escreva alguma coisa',
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30.0)
                  )
                )
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (value) => {
                setState(() {
                  _listThings.add({'text': value});
                })
              }
            )
          ),
          ListItems(_listThings)
        ])
      )
    );
  }

}

class Home extends StatelessWidget {
  Widget _homeView(response) {
    if (response.loading) {
      return Text('Carregando...');
    }

    final things = response.data['things'];

    return Home1(things);
  }

  @override
  Widget build(context) {
    return Query(
      options: QueryOptions(document: ApiQuery.getThings()),
      builder: (result, { refetch }) => _homeView(result)
    );
  }
}


class ListItems extends StatelessWidget{
  final items;

  ListItems(this.items);

  @override
  Widget build(context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final thing = items[i];
          return ListTile(
            title: Text(
              thing['text'],
              style: TextStyle(
                color: Color.fromARGB(255, 48, 48, 48),
                fontFamily: 'Raleway',
                fontSize: 18
              )
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => print(thing),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Color.fromARGB(255, 180, 180, 180),
          );
        },
      )
    );
  }
}

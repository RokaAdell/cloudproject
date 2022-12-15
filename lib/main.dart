import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'putRestaurant.dart';

import 'insertRestaurant.dart';
// 'package:cloud_project/insertRestaurant.dart';
////import 'package:projectcloud/putRestaurant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(),
      home: InsertRestaurant(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getRestaurants() async {
    var res = await http.get(Uri.http('localhost:5000', 'meals'));

    dynamic jsonObj = jsonDecode(res.body);
    return jsonObj['result'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
        centerTitle: true,
      ),
      body: Container(
          child: Card(
        child: FutureBuilder<dynamic>(
            initialData: [],
            future: getRestaurants(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(snapshot.data[index]['name']),
                          //subtitle: Text(snapshot.data[index]['desc']),
                          subtitle: Column(
                            children: [
                              Text(snapshot.data[index]['desc']),
                              Text(snapshot.data[index]['location']),
                            ],
                          ),
                          trailing: Wrap(
                            spacing: 12, 
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    confirtDelete(snapshot.data[index]['id']),
                              ), 
                              IconButton(
                                  icon: Icon(Icons.update),
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateRestaurant(
                                                    id: snapshot.data[index]
                                                        ['id'])));
                                  } 
                                  ), 
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      )),
    );
  }

  confirtDelete(id) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text("delete"),
                content: Text("are you sure"),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text("yes"),
                    onPressed: () async {
                      await http.delete(
                          Uri.http('a764-41-46-32-131.ngrok.io', 'meals/$id'));
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]));
  }
}

class Restaurant {
  final String name, desc, location;
  Restaurant(this.name, this.desc, this.location);
}
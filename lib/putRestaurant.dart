import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class UpdateRestaurant extends StatefulWidget {
 // const UpdateRestaurant({Key? key,required this.id}) : super(key: key);
  String id;
  UpdateRestaurant({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateRestaurantState createState() => _UpdateRestaurantState(id);
}

class _UpdateRestaurantState extends State<UpdateRestaurant> {
 // String id;
 // _UpdateRestaurantState({Key? key, required this.id}) : super(key: key);

  var formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var desc = TextEditingController();
  var location = TextEditingController();

  var id;

  _UpdateRestaurantState(String id){
    this.id=id;
  }
  //(Uri.http('localhost:5000', 'meals'
  update(id) async {
    var res = await http.put(
        Uri.http('a764-41-46-32-131.ngrok.io', 'meals/$id'),
        body: {"name": name.text, "desc": desc.text, "location": location.text},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("update Restauarnt"),
      centerTitle: true,
      ),
      body: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
               margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: formkey,
                child: Expanded(
                  child: Column(children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "wrong";
                        }
                        return null;
                      },
                      controller: name,
                    ),
                    // SizeBox(height:20,),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "wrong";
                        }
                        return null;
                      },
                      controller: desc,
                    ),
                    //SizeBox(height:20,),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "wrong";
                        }
                        return null;
                      },
                      controller: location,
                    ),
                    //SizeBox(height:20,),
                    Container(
                      width: 200,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        child: Text("update restaurant",style: TextStyle(fontSize: 20),),
                        onPressed: ()async {
                          await update(id);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        },
                      ),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

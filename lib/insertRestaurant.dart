import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class InsertRestaurant extends StatefulWidget {
  const InsertRestaurant({Key? key}) : super(key: key);

  @override
  _InsertRestaurantState createState() => _InsertRestaurantState();
}

class _InsertRestaurantState extends State<InsertRestaurant> {
  var formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var desc = TextEditingController();
  var location = TextEditingController();
  insert() async {
    var res = await http.post(
        Uri.http('a764-41-46-32-131.ngrok.io', 'meals'),
        body: {"name": name.text, "desc": desc.text, "location": location.text},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("insert Restauarnt"),
      centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         // mainAxisAlignment:MainAxisAlignment.spaceAround,
          

          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: formkey,
                

                  child: Column(children: [
                    
                    Container(
                       margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "wrong";
                          }
                          return null;
                        },
                        controller: name,
                      ),
                    ),
                    // SizeBox(height:20,),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "wrong";
                          }
                          return null;
                        },
                        controller: desc,
                      ),
                    ),
                    //SizeBox(height:20,),
                    Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "wrong";
                          }
                          return null;
                        },
                        controller: location,
                      ),
                    ),
                    //SizeBox(height:20,),
                    Container(
                      width: 200,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      child: RaisedButton(
                      
                        child: Text("insert restaurant",style: TextStyle(fontSize: 20),),
                        onPressed: ()async {
                          
                           await insert();
                          
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
            
          ],
        ),
      ),
    );
  }
}

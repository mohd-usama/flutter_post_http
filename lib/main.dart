import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DataModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter Login",
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {

  String res= "";
  late List<DataModel> usersList;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

   Future<DataModel> postRequest() async {

    Map data = {
      'Token': 'B12345B8767876ERP565',
      'UserName': "Deepak",
      'Password': "Sipl@1234",
      'IPAddress': "10.0.10.01",
    };
    //encode Map to JSON

   //var body = json.encode(data);
   var url=Uri.parse('http://beta55.sagarinfotech.com/BrownBirdERPAPP/api/Android/Login');

    var response = await http.post(url,body: data);


       if(response.statusCode == 200)
         {
           data = json.decode(response.body);
         }
       else
         {
           print("response not found");
         }
    print("${response.statusCode}");
    print("${response.body}");

    DataModel dataModel = DataModel.fromJson(json.decode(response.body));
   /*  print(dataModel.status);
    print(dataModel.empId);*/
    setState(() {
        res = dataModel.status;
        res = dataModel.empId;
        res = dataModel.loginDetailsId;
        res = dataModel.message;
        res = dataModel.userCode;
        res = dataModel.userGroup;
        res = dataModel.userId;
        res = dataModel.userType;
        usersList=[];
      usersList.add(dataModel);
      //final jsonItems = json.decode(response.body).cast<Map<String,dynamic>>();

    });
    return dataModel;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Request"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter Your Name',
              ),
              controller: _nameController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Password',
                hintText: 'Enter Your Password',
              ),
              controller: _passwordController,
            ),
          ),
          Container(
              height: 50,

              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Login'),
                onPressed: () {
                  print(_nameController.text);
                  print(_passwordController.text);
                  postRequest();
                },
              )
          ),

          FutureBuilder(
              future: postRequest(),
              builder:(context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(

                        child: ListView.builder(
                            scrollDirection: Axis.vertical,

                            shrinkWrap: true,
                            itemCount:usersList.length,
                            padding: const EdgeInsets.only(top: 50,left: 150),
                            itemBuilder: (BuildContext context, int index) {
                              return Text('${usersList[index].status}'+"\n"+
                                  '${usersList[index].empId}'+"\n"+
                                  '${usersList[index].loginDetailsId}'+"\n"+
                                  '${usersList[index].userCode}'+"\n"+
                                  '${usersList[index].userType}'+"\n"+
                                  '${usersList[index].userName}'+"\n"+
                                  '${usersList[index].userGroup}'+"\n"+
                                  '${usersList[index].userId}'+"\n"+
                                  '${usersList[index].message}');

                            }
                        ),
                      );
                }
              }
          )
        ],
      ),
    );
  }
}



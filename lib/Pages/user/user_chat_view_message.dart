import 'dart:convert';

import 'package:automated_payroll/models/user_chatmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserChatView extends StatefulWidget {
  const UserChatView({Key key}) : super(key: key);

  @override
  _UserChatViewState createState() => _UserChatViewState();
}
// user chat view
class _UserChatViewState extends State<UserChatView> {
  List<ChatResult> model = [];

  String loginId = "";

  TextEditingController Login_idController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController MessageController = TextEditingController();
var id;

  addmessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginId = prefs.getString('user') ?? "";
    // String Login_id =Login_idController .text;
    // String person_name = NameController.text;
    String Message = MessageController.text;

    var url = "http://192.168.43.44/automated_payrole/chat_user.php";
    var data = {
      "Login_id": loginId,

      "message": Message,
    };
    var res = await http.post(url, body: data);
    var message = jsonDecode(res.body);
print(Message);
  }



  getChatResultdata() async {

    var url = "http://192.168.43.44/automated_payrole/viewchat.php";
var data ={
  "Login_id":"1"
};
    http.Response response = await http.post(Uri.parse(url),body:data );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("result${data}");
      final chat = (data['result'] as List).map((e) => ChatResult.fromJson(e)).toList();
      setState(() {
        model = chat;
        print(model);
      });
    }
  }
  void showalertdialogue() {
    showDialog(
        context: context,
        builder: (Context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Message"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: MessageController,
                decoration: InputDecoration(hintText: "Type here"),
              ),
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      addmessage();


                      Navigator.of(context).pop(showalertdialogue);
                      MessageController.clear();
                    },
                    child: Text("Add"),
                  )
                ],
              )
            ],
          ),
        ));
  }



  @override
  void initState() {
    getChatResultdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showalertdialogue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text("chat/View to hr")),
        centerTitle: false,
      ),
    body: getbody(),
    );
  }

  Widget getbody() {
    return ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) {
          ChatResult chats = model.elementAt(index);
          print(chats.message);
          return getcard(date: chats.date, message: chats.message,replay:chats.replay );
        });
  }
}

Widget getcard({
  String date,
  var message,
  var replay,
}) {
  return InkWell(
    onLongPress: () {},
    child: Card(
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("date:${date} "),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("messege   ${message}"),
                    ),
                              SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("replay:  ${replay}"),
                              )],
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
        )),


  );
}

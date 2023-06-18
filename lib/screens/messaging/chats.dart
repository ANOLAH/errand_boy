// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../models/professional.dart';
import 'inbox.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  void pushInbox(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Inbox(
        professional: pro,
      );
    }));
  }

  List<Map<String, dynamic>> data = [];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 40, 46),
        title: const Text("Chats"),
      ),
      backgroundColor: Color.fromARGB(255, 3, 26, 36),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              tileColor: Color.fromARGB(255, 3, 26, 36),
              leading: CircleAvatar(
                  backgroundImage: AssetImage(data[index]['image'])),
              title: Text(
                data[index]['firstname'] + ' ' + data[index]['lastname'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Hello',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () => pushInbox(Professional(
                  data[index]['firstname'] + ' ' + data[index]['lastname'],
                  data[index]['email'],
                  data[index]['Category'],
                  data[index]['Contact'],
                  data[index]['Location'],
                  data[index]['image'],
                  data[index]['ratings'],
                  data[index]['cost'],
                  data[index]['available'],
                  data[index]['verified'],
                  data[index]['complete'])),
            ),
          );
        },
      ),
    );
  }
}

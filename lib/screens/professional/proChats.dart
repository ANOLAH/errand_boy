// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../models/user.dart';
import 'proInbox.dart';

class proChat extends StatefulWidget {
  const proChat({super.key});

  @override
  State<proChat> createState() => _proChatState();
}

class _proChatState extends State<proChat> {
  void pushInbox(User pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proInbox(
        user: pro,
      );
    }));
  }

  List<Map<String, dynamic>> data = [
    {
      'firstname': 'Male',
      'lastname': 'Simon',
      'email': 'malesimon@gmail.com',
      'Contact': '+256 700 999 999',
      'image': 'assets/images.jpg'
    },
    {
      'firstname': 'Kavule',
      'lastname': 'Edrine',
      'email': 'kavuleedrine@gmail.com',
      'Contact': '+256 700 999 999',
      'image': 'assets/images (2).jpg',
    },
    {
      'firstname': 'Tumusiime',
      'lastname': 'Deo',
      'email': 'tumudeo234@gmail.com',
      'Contact': '+256 700 999 999',
      'image': 'assets/images (3).jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 19, 23),
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: const Color.fromARGB(255, 31, 44, 52),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              tileColor: const Color.fromARGB(255, 3, 26, 36),
              leading: CircleAvatar(
                  backgroundImage: AssetImage(data[index]['image'])),
              title: Text(
                  data[index]['firstname'] + ' ' + data[index]['lastname'],
                  style: const TextStyle(color: Colors.white)),
              subtitle: const Text('Hi, I would like to make an appointment...',
                  style: TextStyle(color: Color.fromARGB(255, 133, 150, 160))),
              onTap: () => pushInbox(User(
                  data[index]['firstname'] + ' ' + data[index]['lastname'],
                  data[index]['email'],
                  data[index]['Contact'],
                  data[index]['image'])),
            ),
          );
        },
      ),
    );
  }
}

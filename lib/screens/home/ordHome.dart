import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer/drawer.dart';
import 'package:flutter_application_1/screens/userRequests/sentRequests.dart';

class ordHome extends StatefulWidget {
  const ordHome({super.key});

  @override
  State<ordHome> createState() => _ordHome();
}

class _ordHome extends State<ordHome> {
  var _currentPage = 0;
  var user = FirebaseAuth.instance.currentUser;

  var _pages = [const Drawer_(), const SentRequest()];

  List<Map<String, dynamic>> data = [];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(element['email'])
          .set(element);
    }
  }

  @override
  void initState() {
    super.initState();
    // addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages.elementAt(_currentPage)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'requests'),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'chats',
          ),
        ],
        currentIndex: _currentPage,
        backgroundColor: const Color.fromARGB(255, 31, 44, 52),
        fixedColor: const Color.fromARGB(255, 2, 168, 132),
        unselectedItemColor: const Color.fromARGB(255, 133, 150, 160),
        onTap: (int inIndex) {
          setState(() {
            _currentPage = inIndex;
          });
        },
      ),
    );
  }
}

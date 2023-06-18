// ignore_for_file: camel_case_types

import 'package:flutter_application_1/screens/professional/request/jobs.dart';

import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '_profile.dart';
import 'package:flutter/material.dart';

import 'proChats.dart';
import 'reviews.dart';

class proHome extends StatefulWidget {
  const proHome({super.key});

  @override
  State<proHome> createState() => _proHomeState();
}

class _proHomeState extends State<proHome> {
  var _currentPage = 2;

  final _pages = [
    const Reviews(),
    const proChat(),
    const Profile(),
    const job(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages.elementAt(_currentPage)),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: const Color.fromARGB(255, 31, 44, 52),
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(bodySmall: const TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.reviews),
              label: 'Reviews',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Jobs',
            ),
            // Add a signout button
            BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Wrapper()));
                },
              ),
              label: 'Sign Out',
            ),
          ],
          currentIndex: _currentPage,
          selectedItemColor: const Color.fromARGB(255, 2, 168, 132),
          unselectedItemColor: const Color.fromARGB(255, 133, 150, 160),
          onTap: (int inIndex) {
            setState(() {
              _currentPage = inIndex;
            });
          },
        ),
      ),
    );
  }
}

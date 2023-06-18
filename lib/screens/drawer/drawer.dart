// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/drawer/profile.dart';
import 'package:flutter_application_1/screens/home/proList.dart';
import 'package:flutter_application_1/screens/wrapper.dart';
import 'share.dart';
import 'help.dart';
import 'about.dart';

class Drawer_ extends StatefulWidget {
  const Drawer_({super.key});

  @override
  State<Drawer_> createState() => _Drawer();
}

class _Drawer extends State<Drawer_> {
  String name = '';
  void pushProfile() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return const Profile();
    }));
  }

  void pushShare() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return const Share();
    }));
  }

  void pushHelp() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return const Help();
    }));
  }

  void pushAbout() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return const About();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 31, 44, 52),
          title: Card(
              child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          )),
          actions: [
            PopupMenuButton(
                color: const Color.fromARGB(255, 31, 44, 52),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                        value: "Apply Filters",
                        child: Text(
                          "Apply Filters",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ]),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 18, 27, 34),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/handshake.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    'Errand Boy',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 2, 168, 132),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: const Text('Profile',
                    style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushProfile(),
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: const Text('Sign Out',
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const Wrapper()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.help,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title:
                    const Text('Help', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushHelp(),
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                title: const Text('About Us',
                    style: TextStyle(color: Colors.white)),
                onTap: () => {
                  pushAbout(),
                },
              ),
              const Divider(),
              const Expanded(
                child: SizedBox(
                  height: 300,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => FirebaseAuth.instance.signOut(),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20),
                ),
                icon: const Icon(
                  Icons.power_settings_new,
                  color: Color.fromARGB(255, 2, 168, 132),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: const Color.fromARGB(255, 44, 51, 51)),
              ),
            ],
          ),
        ),
        body: const proList());
  }
}

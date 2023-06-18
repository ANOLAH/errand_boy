import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: const Color.fromARGB(255, 44, 51, 51),
        ),
        backgroundColor: const Color.fromARGB(255, 57, 91, 100),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/profilePicture.jpg'),
                radius: 100,
              ),
              const Text(
                'Signed In as',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('uniqueId', isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: spinkit,
                      );
                    } else {
                      var data = snapshot.data!.docs[0].data();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Firstname: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 165, 201, 202))),
                              Text(data['firstname'].toString().toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 231, 246, 242),
                                  )),
                              const Icon(Icons.edit,
                                  color: Color.fromARGB(255, 2, 168, 132)),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              const Text("Lastname: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 165, 201, 202))),
                              Text(data['lastname'].toString().toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 231, 246, 242),
                                  )),
                              const Icon(Icons.edit,
                                  color: Color.fromARGB(255, 2, 168, 132)),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              const Text('Location: ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 165, 201, 202),
                                  )),
                              Text(
                                data['Location'].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 231, 246, 242)),
                              ),
                              const Icon(Icons.edit,
                                  color: Color.fromARGB(255, 2, 168, 132)),
                            ],
                          ),
                        ],
                      );
                    }
                  }),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  const Text('Email: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 165, 201, 202),
                      )),
                  Text(
                    user.email!,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 231, 246, 242)),
                  ),
                  const Icon(Icons.edit,
                      color: Color.fromARGB(255, 2, 168, 132)),
                ],
              ),
            ],
          ),
        ));
  }
}

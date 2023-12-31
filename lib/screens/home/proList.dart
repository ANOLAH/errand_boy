// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';
import 'package:flutter_application_1/screens/home/subscribers.dart';
import 'package:flutter_application_1/screens/userRequests/request.dart';
import '../../models/professional.dart';

class proList extends StatefulWidget {
  const proList({super.key});

  @override
  State<proList> createState() => _proListState();
}

class _proListState extends State<proList> {
  String name = '';

  void pushRequest(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return request(professional: pro);
    }));
  }

  void pushSubscribers(String category) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        return subscribers(category: category);
      }),
    );
  }

  double rating(List ratingList) {
    int len = ratingList.length;
    int sum = 0;
    for (int i in ratingList) {
      sum += i;
    }
    return sum / len;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 44, 52),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('accountType', isEqualTo: 'Professional')
            .snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: spinkit,
                )
              : (name.isEmpty)
                  ? ListView(padding: const EdgeInsets.all(5), children: [
                      InkWell(
                          onTap: () => pushSubscribers(
                              'Electricians & Electrical Works'),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 200,
                            width: 500,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/electicity.png'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Electricians & Electrical Works',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                          onTap: () => pushSubscribers('Food & Nutrition'),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 200,
                            width: 500,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/food.png'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Food & Nutrition',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      InkWell(
                          onTap: () => pushSubscribers('Plumbing & Waterworks'),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 200,
                            width: 500,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/plumbing.png'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Plumbing & Waterworks',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      InkWell(
                          onTap: () => pushSubscribers('Tailoring'),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 200,
                            width: 500,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/tailor.png'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Tailoring',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      InkWell(
                          onTap: () => pushSubscribers('Woodworking'),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 200,
                            width: 500,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/wood.png'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Woodworking',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ])
                  : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                        if (data['firstname']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase()) ||
                            data['lastname']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase())) {
                          return Card(
                              child: ListTile(
                            title: Text(
                                data['firstname'] + ' ' + data['lastname'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/proProfile.png'),
                            ),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 248, 226, 31),
                                ),
                                Text(
                                    '${rating(data['ratings']).toStringAsFixed(1)}/5 stars')
                              ],
                            ),
                            onTap: () => pushRequest(Professional(
                                data['firstname'] + data['lastname'],
                                data['email'],
                                data['Category'],
                                data['Contact'],
                                data['Location'],
                                data['image'],
                                data['ratings'],
                                data['cost'],
                                data['available'],
                                data['verified'],
                                data['complete'])),
                          ));
                        }
                        return Container();
                      });
        },
      ),
    );
  }
}

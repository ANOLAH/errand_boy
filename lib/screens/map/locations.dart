// ignore_for_file: unused_import, camel_case_types, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/professional.dart';
import 'package:flutter_application_1/models/spinkit.dart';
import 'package:flutter_application_1/screens/messaging/proProfile.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/main.dart';
import 'package:image_picker/image_picker.dart';

class request extends StatefulWidget {
  const request({super.key, required this.professional});

  final Professional professional;

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  String? date, time;
  DateTime dt = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  final detailController = TextEditingController();
  final descrController = TextEditingController();
  Uint8List? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childname).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void pushproProfile(Professional pro) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return proProfile(professional: pro);
    }));
  }

  @override
  void dispose() {
    locationController.dispose();
    detailController.dispose();
    super.dispose();
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    } else {
      return null;
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Submit request'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              tooltip: 'submit',
              onPressed: () => makeRequest(widget.professional, _image),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 31, 44, 52),
        ),
        backgroundColor: const Color.fromARGB(255, 57, 91, 100),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.professional.image),
                      radius: 30,
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.professional.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 231, 246, 242)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(widget.professional.Category,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 165, 201, 202)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () =>
                                            pushproProfile(widget.professional),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 31, 44, 52),
                                        ),
                                        child: const Text('Profile'))
                                  ],
                                ),
                                const SizedBox(height: 7),
                                const Divider(height: 2),
                                const SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(Icons.photo_camera),
                                        tooltip: 'Pick Image',
                                        onPressed: selectImage,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                _image == null
                                    ? const Text('No image selected.')
                                    : Image.memory(_image!),
                              ],
                            ))),
                  ],
                ),
                const SizedBox(height: 7),
                const Divider(height: 2),
                DateTimePicker(
                  type: DateTimePickerType.Both,
                  initialSelectedDate: dt.add(const Duration(days: 1)),
                  startDate: dt,
                  endDate: dt.add(const Duration(days: 365)),
                  startTime: DateTime(dt.year, dt.month, dt.day, 6),
                  endTime: DateTime(dt.year, dt.month, dt.year, 18),
                  timeInterval: const Duration(minutes: 15),
                  timeOutOfRangeError: "Sorry, can't pick the selected date",
                  onDateChanged: (value) {
                    setState((() =>
                        {date = DateFormat('yyyy-dd-MM').format(value)}));
                  },
                  onTimeChanged: (value) {
                    setState(() => {time = DateFormat.Hms().format(value)});
                  },
                ),
                const SizedBox(height: 7),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 165, 201, 202)),
                        controller: locationController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: 'Location',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 231, 246, 242))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null ? null : 'This is a required field',
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 165, 201, 202)),
                        controller: detailController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: 'Details e.g main gate',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 231, 246, 242))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null ? null : 'This is a required field',
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 165, 201, 202)),
                        controller: descrController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            labelText: 'Job description',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 231, 246, 242))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null ? null : 'This is a required field',
                      ),
                      const SizedBox(height: 4),
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      "https://img.myloview.com/stickers/default-avatar-profile-vector-user-profile-400-200353986.jpg"),
                                ),
                          Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(Icons.add_a_photo),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future makeRequest(Professional pro, Uint8List? image) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: spinkit),
    );

    try {
      // Upload the image to Firebase storage and get the download URL
      String photoURL = '';
      if (image != null) {
        photoURL = await uploadImageToStorage('RequestImages', image);
      }

      // Get the current user's email
      var user = FirebaseAuth.instance.currentUser;

      // Create a new document in the 'requests' collection
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(date.toString().trim() + time.toString().trim())
          .set({
        'uniqueId': pro.email.trim(),
        'recepient': pro.name.trim(),
        'request': user!.email,
        'date': date,
        'time': time,
        'location': locationController.text.trim(),
        'details': detailController.text.trim(),
        'status': 'Pending',
        'description': descrController.text.trim(),
        'photoURL': photoURL // Add the download URL to the document
      });
    } catch (e) {
      print(e);
    }

    Navigator.pop(context);
  }
}

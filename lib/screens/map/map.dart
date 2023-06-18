import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ServiceRequestPage extends StatefulWidget {
  @override
  _ServiceRequestPageState createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  File _image;
  final _picker = ImagePicker();
  TextEditingController _serviceTypeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImageToStorage() async {
    String imageUrl;

    // Create a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
        '_' +
        _image.path.split('/').last;

    // Upload the file to Firebase Storage
    final Reference reference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    final UploadTask uploadTask = reference.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    // Get the URL of the uploaded image
    imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  @override
  void dispose() {
    _serviceTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Request'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Service Type',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _serviceTypeController,
                decoration: InputDecoration(
                  hintText: 'Enter service type',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Upload Picture',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              _image != null
                  ? Image.file(
                      _image,
                      height: 150.0,
                    )
                  : GestureDetector(
                      onTap: () => getImage(),
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Add Picture',
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Upload the image to Firebase Storage
                    String imageUrl = await uploadImageToStorage();

                    // Save the service request data to Firebase Firestore
                    FirebaseFirestore.instance
                        .collection('service_requests')
                        .add({
                      'serviceType': _serviceTypeController.text,
                      'description': _descriptionController.text,
                      'imageUrl': imageUrl,
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    // Clear the form fields and image
                    _serviceTypeController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _image = null;
                    });

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Service request submitted successfully!'),
                      ),
                    );
                  },
                  child: Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

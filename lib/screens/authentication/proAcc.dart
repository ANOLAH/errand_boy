// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/spinkit.dart';
import '../../main.dart';
import '../../utils.dart';

const List<DropDownValueModel> list = <DropDownValueModel>[
  DropDownValueModel(name: 'Tailoring', value: 'Tailoring'),
  DropDownValueModel(name: 'Woodworking', value: 'Woodworking'),
  DropDownValueModel(
      name: 'Plumbing & Waterworks', value: 'Plumbing & Waterworks'),
  DropDownValueModel(
      name: 'Electricians & Electrical Works',
      value: 'Electricians & Electrical Works'),
  DropDownValueModel(name: 'Food & Nutrition', value: 'Food & Nutrition'),
];

class proAccount extends StatefulWidget {
  final Function() isLogin;
  final Function() isPro;
  const proAccount({super.key, required this.isLogin, required this.isPro});

  @override
  State<proAccount> createState() => _proAccountState();
}

class _proAccountState extends State<proAccount> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  final _categoryController = SingleValueDropDownController();
  final _costController = TextEditingController();

  String? holder;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    _categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                width: 600,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('./assets/logo.png'))),
              ),
              const SizedBox(height: 20),
              const Text('Create an account',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromARGB(255, 0, 65, 118))),
              TextFormField(
                controller: _fnameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'First Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null ? null : 'This is a required field',
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _lnameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Last Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null ? null : 'This is a required field',
              ),
              const SizedBox(
                height: 5,
              ),
              DropDownTextField(
                controller: _categoryController,
                clearOption: true,
                enableSearch: false,
                textFieldDecoration:
                    const InputDecoration(hintText: 'Select a category'),
                validator: (value) =>
                    value != null ? null : 'This is a required field',
                dropDownItemCount: 5,
                dropDownList: list,
                onChanged: (value) {
                  holder = value.value;
                },
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _contactController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Contact'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null ? null : 'This is a required field',
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email.trim())
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _locationController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Location'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null ? null : 'This is a required field',
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _costController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Cost'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null ? null : 'This is a required field',
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min 6 characters'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: const Color.fromARGB(255, 44, 51, 51)),
                icon: const Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: signUp,
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black54, fontSize: 17),
                    text: 'Already have an account?',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.isPro,
                        text: 'SignIn',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: spinkit),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_emailController.text.trim())
          .set({
        'uniqueId': user!.uid,
        'firstname': _fnameController.text.trim(),
        'lastname': _lnameController.text.trim(),
        'email': _emailController.text.trim(),
        'Contact': _contactController.text.trim(),
        'Category': holder,
        'Location': _locationController.text.trim(),
        'accountType': 'Professional',
        'identifier': '${user.uid}Professional',
        'image': 'assets/proProfile.png',
        'ratings': [],
        'cost': int.parse(_costController.text.trim()),
        'available': true,
        'verified': false,
        'complete': 0
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

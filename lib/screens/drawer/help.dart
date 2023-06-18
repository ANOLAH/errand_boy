import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri email =
        Uri.parse('mailto:arnoldndoro0@gmail.com?subject=%20&body=%20');

    Future<void> sendEmail() async {
      if (!await launchUrl(email)) {
        throw 'Could not launch $email';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset("assets/support-img.png"),
              const Text('Experiencing some difficulties?'),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = sendEmail,
                  text: 'Contact Us',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

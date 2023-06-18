import 'package:flutter/material.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: const [
                Icon(Icons.share),
                Text('Share our application around the communitee!'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

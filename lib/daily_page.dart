import 'package:flutter/material.dart';

class DailyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Notes'),
      ),
      body: Center(
        child: Text('This is where you can keep your notes.'),
      ),
    );
  }
}

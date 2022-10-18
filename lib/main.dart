import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appstyrd Bil',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const DeciderScreen(),
    ),
  );
}

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
    );
  }
}
//Test
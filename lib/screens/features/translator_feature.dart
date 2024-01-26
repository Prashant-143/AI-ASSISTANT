import 'package:flutter/material.dart';

class TransaltorFeature extends StatefulWidget {
  const TransaltorFeature({super.key});

  @override
  State<TransaltorFeature> createState() => _TransaltorFeatureState();
}

class _TransaltorFeatureState extends State<TransaltorFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        title: const Text('Multi Langauge Transalator'),
      ),

      //Body

      body: ListView(
        children: const [],
      ),
    );
  }
}

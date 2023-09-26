import 'package:flutter/material.dart';

class ShowRegistersView extends StatefulWidget {
  const ShowRegistersView({super.key, required this.identificationNumber});
  
  final String identificationNumber;

  @override
  State<ShowRegistersView> createState() => _ShowRegistersViewState();
}

class _ShowRegistersViewState extends State<ShowRegistersView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('EDWIN'),
    );
  }
}
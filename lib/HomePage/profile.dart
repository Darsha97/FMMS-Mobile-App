import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
   final ScrollController controller;

  Profile({required this.controller});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
import 'package:flutter/material.dart';
import '../models/show.dart';

class ShowTile extends StatelessWidget {
  final Show show;
  final VoidCallback onTap;

  const ShowTile({required this.show, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(show.image, width: 50, fit: BoxFit.cover),
      title: Text(show.name),
      onTap: onTap,
    );
  }
}

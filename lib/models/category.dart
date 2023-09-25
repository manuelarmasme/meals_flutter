import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    //default value doesnt need required
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}

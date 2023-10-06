import 'package:meals/main.dart';
import 'package:meals/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectedCategory
  });

  final Category category;

  final void Function() onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    // InkWell helps us to give to our grid items the hability to tap them and create an action
    // gesturedectetor is another option to inkwell, but with  InkWell with could have a visual feedback also
    return InkWell(
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          //! we are telling flutter that title large is going to be define
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

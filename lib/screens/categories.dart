import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //push help us to show a screnn and with pop we could remove the screen like it happens with the modal
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold it's a good practices having this widget as initial screen base on the app
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //horizontali we have two columns with this option
            crossAxisCount: 2,

            //aspect ratio
            childAspectRatio: 3 / 2,

            //spacing horizontal
            crossAxisSpacing: 20,
            //spacing vertical
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectedCategory: () {
                _selectedCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}

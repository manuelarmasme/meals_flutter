import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  //variable to create favorite feature
  //on this variable we are going to have all the meals
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //function that bring a message
  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  //function that helps to remove or add a meal to favorites
  void _toggleMealFavoriteStatus(Meal meal) {
    //On this function I pass a meal an with isExisting
    //I want to check if that meal is true or false
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer on favorites');
      });
    } else {
      setState(() {
      _favoriteMeals.add(meal);
        _showInfoMessage('Meal is added to favorite');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToogleFavorite: _toggleMealFavoriteStatus,
    );
    // we use var because this variables is going to change a lot through the app navigation
    var activePageTitle = 'Categories';

    //when the user try to go to favorites screen
    if (_selectedPageIndex == 1) {
      //in this case we reuse MealsScreen because it has the structure that we need to our favorite screen
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToogleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

//the initial k is a convention on flutter to global variable
// we are creating this global variable to start
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // We use async and await because the returning value we are going to have it in the future
  void _setScreen(String identifier) async {
    //closing the drawer and other screen
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      //navigating to filter screen
      //push is a generi method we could tell it that we are passing a map
      //we are telling that the value that you are going to recieve is a map
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final activeFilters = ref.watch(filtersProvider);

    final availableMeals = meals.where((meal) {
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }

      if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }

      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }

      if(activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }

      //we use this to return only the meals that we want
      return true;

    
    }).toList();

    Widget activePage = CategoriesScreen(
      //this availableMeals helps to filter the meals that are selected
      availableMeals: availableMeals,
    );
    // we use var because this variables is going to change a lot through the app navigation
    var activePageTitle = 'Categories';

    //when the user try to go to favorites screen
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      //in this case we reuse MealsScreen because it has the structure that we need to our favorite screen
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
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

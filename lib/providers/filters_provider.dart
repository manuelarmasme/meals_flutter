import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  //constructor
  FiltersNotifier()
      : super({
          //iniatialize the enum filter values to default value false
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  //this function is to store the filters choosen by the user
  void setFilters(Map<Filter, bool> choosenFilters){
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;
    //not allowed because this is mutating the state for maps we use another approach

    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

//this provider return a list of filtered meals
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);

  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
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
    
  });
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

//let's set up the provider
class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  //constructor
  FavoriteMealsNotifier() : super([]);

  //function to add meals to the list
  // return a boolean value
  bool toggleMealFavoriteStatus(Meal meal) {
    //lets store on a variable is the meal is contain on the state
    // we are going to get a true or false response
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      //m is meal I use m just to don't get confuse
      //mealIsFavorite is true then just don't add it to the state
      state = state.where((m) => m.id != meal.id).toList();
      return false;
      // We return false because the meals was remove it
    } else {
      //in case where mealIsFavorite is false add the new meal to the state
      state = [...state, meal];
      return true;
      //we return true because the meal was added
    }
  }
}

// we use StateNotifierProvider because the data is more dynamic
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  //we do this to connect FavoriteMealsNotifier with favoriteMealsProvider
  return FavoriteMealsNotifier();
});
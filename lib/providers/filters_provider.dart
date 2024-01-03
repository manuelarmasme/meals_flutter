import 'package:flutter_riverpod/flutter_riverpod.dart';

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

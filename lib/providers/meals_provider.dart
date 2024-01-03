import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

//Provider class is perfect for static data

final mealsProvider = Provider((ref){
  return dummyMeals;
});
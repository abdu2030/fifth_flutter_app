//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //StateNotifier is used for complex state logic when using flutter riverpod.it is used when we have StateNotifier is for:Lists, Objects, Business logic, Multiple state changes and Clean architecture
  FavoriteMealsNotifier() : super([]);

  bool toggelMealFavoriteStatus(Meal meal) {
    final mealsFavorite = state.contains(
      meal,
    ); //Checks if the meal already exists in the favorites list.

    if (mealsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true; //this means Take all current meals, Add the new meal and Create a NEW list
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
      return FavoriteMealsNotifier();
    });

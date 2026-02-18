import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        //MaterialPageRoute is one of the most common ways to navigate between screens in Flutter.It creates a route (a page transition) that follows Material Design animations.
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    ); // same as Navigator.of(context).push(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(17),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //SliverGridDelegateWithFixedCrossAxisCount is a layout manager that arranges its children in a grid with a fixed number of columns (crossAxisCount). It also allows you to specify the aspect ratio of the children and the spacing between them.
        crossAxisCount: 2,
        childAspectRatio:
            3 /
            2, //Controls the width-to-height ratio of each grid item.Width is 1.5 times the height.
        crossAxisSpacing: 20, //20 pixels horizontal space between grid items.
        mainAxisSpacing: 20, //20 pixels vertical space(row)
      ),
      children: [
        //availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
  _animationController; //explicit animation controller that we can control manually
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward(); // this start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        //MaterialPageRoute is one of the most common ways to navigate between screens in Flutter.It creates a route (a page transition) that follows Material Design animations.
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    ); // same as Navigator.of(context).push(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        ),
        child: child,
      ), //position is: An Animation of Offset that tells Flutter how the widget should move
    );
  }
}

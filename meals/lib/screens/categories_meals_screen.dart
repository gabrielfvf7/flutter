import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoriesMealsScreen extends StatelessWidget {
  static const routeName = '/categories-meals';

  @override
  Widget build(BuildContext context) {
    final routerArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routerArgs['title'];
    final categoryId = routerArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where((element) => element.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: categoryMeals[index].id,
          title: categoryMeals[index].title,
          imageUrl: categoryMeals[index].imageUrl,
          duration: categoryMeals[index].duration,
          complexity: categoryMeals[index].complexity,
          affordability: categoryMeals[index].affordability,
        ),
        itemCount: categoryMeals.length,
      ),
    );
  }
}

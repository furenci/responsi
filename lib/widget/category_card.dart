import 'package:flutter/material.dart';
import '../models/category.dart';
import '../screens/meal_list_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(category.strCategoryThumb),
        title: Text(category.strCategory),
        subtitle: Text(category.strCategoryDescription,
            maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MealListScreen(category: category.strCategory),
            ),
          );
        },
      ),
    );
  }
}

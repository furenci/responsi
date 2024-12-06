import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import '../models/meal.dart';
import '../widget/meal_card.dart';

class MealListScreen extends StatelessWidget {
  final String category;

  const MealListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals in $category"),
      ),
      body: FutureBuilder<List<Meal>>(
        future: ApiService().fetchMeals(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return MealCard(meal: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}

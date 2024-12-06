import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;

  MealDetailScreen({required this.mealId});

  Future<void> _launchVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Details"),
      ),
      body: FutureBuilder<Meal>(
        future: ApiService().fetchMealDetail(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final meal = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      meal.strMealThumb,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                    Text(
                      meal.strMeal,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    // Display Instructions for the meal
                    Text(
                      meal.strInstructions ?? 'No instructions available.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    // Display YouTube tutorial button if available
                    ElevatedButton(
                      onPressed: () {
                        final url = meal.strYoutube ?? '';
                        if (url.isNotEmpty) {
                          _launchVideo(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No video available')),
                          );
                        }
                      },
                      child: Text('Watch Tutorial'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

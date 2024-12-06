import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  final String baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  // Fetch Categories from API
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}categories.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['categories'] as List)
            .map((json) => Category.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // Fetch Meals based on Category from API
  Future<List<Meal>> fetchMeals(String category) async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}filter.php?c=$category'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] == null) {
          return [];
        }
        return (data['meals'] as List)
            .map((json) => Meal.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }

  // Fetch Meal Details by ID from API
  Future<Meal> fetchMealDetail(String mealId) async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}lookup.php?i=$mealId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] == null || data['meals'].isEmpty) {
          throw Exception('Meal not found');
        }
        return Meal.fromJson(data['meals'][0]);
      } else {
        throw Exception('Failed to fetch meal details');
      }
    } catch (e) {
      throw Exception('Error fetching meal details: $e');
    }
  }
}

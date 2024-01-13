library recipe_management.globals;

// https://api.spoonacular.com/recipes/findByIngredients?ingredients=apple,+flour,+sugar&number=2&apiKey=9cdd0725f3a1411fae547fba718cce83

String apiKey = '9cdd0725f3a1411fae547fba718cce83';
String apiBaseUrl = 'https://api.spoonacular.com/';

enum ViewState { idle, busy }

class Endpoints {
  static String searchByIngredients = 'recipes/findByIngredients';
}
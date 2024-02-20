abstract class AIRepository {
  Future<List<AIRecipe extends Coding>> fetchRecipe(String aiPrompt);
}
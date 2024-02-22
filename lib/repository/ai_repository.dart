import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:conduit_codable/conduit_codable.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:recipe_management/model/ai_recipe.dart';
import 'package:recipe_management/utils/app_constants.dart';

abstract class AIRepository {
  Future<List<AIRecipe>> fetchRecipe({required List<String> aiPrompt, String? prompt});
}

class ChatGPTRepository implements AIRepository {
  final openaiApiKey = Platform.environment['OPENAI_API_KEY'];
  final client = OpenAIClient(apiKey: AppConstants.chatGptKey);

  void createMessage(String prompt) async {
    final request = CreateMessage(
      role: 'user',
      content: prompt
    );
  }

  late OpenAI openAI;

  @override
  Future<List<AIRecipe>> fetchRecipe({required List<String> aiPrompt, String? prompt}) async  {
    openAI = OpenAI.instance.build(
      token: kTokenKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20)
      ), enableLog: true
    );

    // final request = CreateMessage(
    //     role: 'user',
    //     content: prompt!
    // );
    const String prompt = 'Create a JSON structure for a unique recipe. The recipe should have a title, '
        'a list of ingredients, instructions (each as a dictionary with an instruction number represented '
        'as an integer and the instruction itself as a string), and the country of origin. Each ingredient '
        'should be represented as a dictionary with a name and amount (double or null if not). The recipes should '
        'include venison, chocolate, blueberries, vanilla ice cream, and chiles. Include nutritional '
        'information in the form of a dictionary. The nutritional info should be for the completed recipe '
        'and based on serving size. It should contain vitamins, calories, sodium, carbohydrates, etc';

    final res = await client.createChatCompletion(
      request: const CreateChatCompletionRequest(
        model: ChatCompletionModel.model(ChatCompletionModels.gpt35Turbo),
        messages: [
          ChatCompletionMessage.system(
            content: prompt,
          ),
          ChatCompletionMessage.user(
            content: ChatCompletionUserMessageContent.string('aiPrompt'),
          ),
        ],
        temperature: 0,
      ),
    );

    String? json = res.choices.first.message.content;
    if(json != null) {
      Map<String, dynamic> jsonMap = jsonDecode(json);
      KeyedArchive archive = KeyedArchive(jsonMap);
      AIRecipe recipe = AIRecipe()..decode(archive);
      return [recipe];
    }
    return [];
  }
}
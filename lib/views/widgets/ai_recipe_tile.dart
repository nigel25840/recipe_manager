import 'package:flutter/material.dart';
import 'package:recipe_management/utils/app_constants.dart';

import '../../model/ai_recipe.dart';

class AIRecipeTile extends StatelessWidget {
  AIRecipeTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final AIRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title ?? '',
                  style: AppConstants.kTextStyleDefault,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Add this line to handle overflow
                ),
                SizedBox(height: 20),
                Text('Country of Origin: ${recipe.countryOfOrigin}', style: AppConstants.kTextStyleDefault),
                // Add more Text widgets or other content as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
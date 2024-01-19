import 'package:flutter/material.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add image thumbnail here

          // Expanded widget ensures that the Column takes up the available space
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
                Text('Likes: ${recipe.likes.toString()}', style: AppConstants.kTextStyleDefault),
                // Add more Text widgets or other content as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}


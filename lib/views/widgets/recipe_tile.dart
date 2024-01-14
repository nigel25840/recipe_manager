import 'package:flutter/material.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({
    Key? key,
    required this.recipe
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 25),
        child: Row(
          children: [
            // image thumbnail here
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.title ?? '', style: AppConstants.kTextStyleDefault),
                Text('Likes: ${recipe.likes.toString()}', style: AppConstants.kTextStyleDefault)
                // Text(recipe.),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

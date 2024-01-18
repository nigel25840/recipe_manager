import 'package:flutter/material.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/utils/app_constants.dart';

class IngredientTile extends StatelessWidget {
  IngredientTile({
    Key? key,
    required this.ingredient
  }) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 25),
        child: Container(
          color: ingredient.onHand ? Colors.greenAccent : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Text(ingredient.name ?? '', style: AppConstants.kTextStyleDefault)),
            ],
          ),
        ),
      ),
    );
  }
}
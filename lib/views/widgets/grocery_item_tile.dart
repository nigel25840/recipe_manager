import 'package:flutter/material.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/utils/app_constants.dart';

class GroceryItemTile extends StatelessWidget {
  GroceryItemTile({
    Key? key,
    required this.ingredient
  }) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ingredient.onHand ? Colors.greenAccent : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child: Text(ingredient.name ?? '', style: AppConstants.kTextStyleDefault)),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({
    Key? key,
    required this.recipeTitle,
    required this.thumbnailUrl,
    required this.description,
  }) : super(key: key);

  final String recipeTitle;
  final String thumbnailUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // image thumbnail here
          Column(
            children: [
              Text(recipeTitle),
              Text(description),
            ],
          ),
        ],
      ),
    );
  }
}

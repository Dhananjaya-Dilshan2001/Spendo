import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';

class CategoryCard extends StatelessWidget {
  final Color color;
  final String categoryName;
  final VoidCallback? onLongPress;
  const CategoryCard({
    super.key,
    required this.color,
    required this.categoryName,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onLongPress: () {
        onLongPress?.call();
      },
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: width * 0.01),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: width * 0.02,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              child: Icon(
                Icons.category,
                color: Colors.white,
                size: width * 0.035,
              ),
              radius: width * 0.03,
              backgroundColor: AppColors.color1,
            ),
            SizedBox(width: 10),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              categoryName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.color1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

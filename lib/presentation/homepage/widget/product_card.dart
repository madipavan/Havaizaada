import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_color.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String brand;
  final double oldPrice;
  final double newPrice;
  final double discount;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.oldPrice,
    required this.newPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight, image: NetworkImage(imageUrl)),
                  ),
                ),
              ),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(25, 30)),
                      onPressed: () {},
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ), //image
          //details of product
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(brand),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '₹${oldPrice.toString()}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.grey,
                          fontSize: 12,
                          color: AppColors.grey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '₹${newPrice.toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "${discount.toString()}% OFF",
                  style: TextStyle(
                      color: AppColors.scaffoldBg,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_color.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String brand;
  final double oldPrice;
  final double newPrice;
  final double discount;
  final Function()? onAdding;
  final bool isCartView;

  const ProductCard({
    super.key,
    this.isCartView = false,
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.oldPrice,
    required this.newPrice,
    required this.discount,
    this.onAdding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      color: Colors.white,
      child: isCartView
          ? Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _productImage(imageUrl, isCartView, () {}), //image
                    //details of product
                    _productDetails(
                        title, brand, oldPrice, newPrice, discount, isCartView),
                  ],
                ),
                _quantityIncreaseDcrease(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productImage(imageUrl, isCartView, onAdding!), //image
                //details of product
                _productDetails(
                    title, brand, oldPrice, newPrice, discount, false),
              ],
            ),
    );
  }
}

Widget _productImage(String imageUrl, bool isCartView, VoidCallback onAdding) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      height: isCartView ? 100 : 160, //image size for cart
      width: isCartView ? 100 : double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
      child: !isCartView
          ? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: onAdding,
                  child:
                      const Icon(Icons.add_shopping_cart, color: Colors.white),
                ),
              ),
            )
          : SizedBox(),
    ),
  );
}

Widget _productDetails(String title, String brand, double oldPrice,
    double newPrice, double discount, bool isCartView) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(brand),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              '₹${oldPrice.toStringAsFixed(2)}',
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
              '₹${newPrice.toStringAsFixed(2)}',
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
  );
}

Widget _quantityIncreaseDcrease() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "₹12345.00",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
              Text("2"),
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
        )
      ],
    ),
  );
}

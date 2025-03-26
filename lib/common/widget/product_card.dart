import 'package:flutter/material.dart';

import '../../core/configs/theme/app_color.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String brand;
  final double oldPrice;
  final double newPrice;
  final double discount;
  final VoidCallback? onAdding;
  final VoidCallback? increaseQuantity;
  final VoidCallback? decreaseQuantity;
  final VoidCallback? removeProduct;
  final int? quantity;
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
    this.decreaseQuantity,
    this.increaseQuantity,
    this.removeProduct,
    this.quantity = 1,
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
                    _productImage(
                      imageUrl,
                      isCartView,
                      () {},
                    ), //image
                    //details of product
                    _productDetails(
                        title, brand, oldPrice, newPrice, discount, isCartView),
                  ],
                ),
                _quantityIncreaseDcrease(increaseQuantity, decreaseQuantity,
                    quantity, removeProduct),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productImage(
                  imageUrl,
                  isCartView,
                  onAdding!,
                ), //image
                //details of product
                _productDetails(
                    title, brand, oldPrice, newPrice, discount, false),
              ],
            ),
    );
  }
}

Widget _productImage(
  String imageUrl,
  bool isCartView,
  VoidCallback onAdding,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      height:
          isCartView ? 100 : 140, // You can still adjust for mobile & tablet
      width: isCartView ? 80 : double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.contain,
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
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
    ),
  );
}

Widget _quantityIncreaseDcrease(
    VoidCallback? increaseQuantity,
    VoidCallback? decreaseQuantity,
    int? quantity,
    VoidCallback? removeProduct) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: removeProduct,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(10),
            child: Text(
              "Remove",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              IconButton(
                  onPressed: decreaseQuantity ?? () {},
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
              Text(
                quantity.toString(),
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                  onPressed: increaseQuantity ?? () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ],
          ),
        )
      ],
    ),
  );
}

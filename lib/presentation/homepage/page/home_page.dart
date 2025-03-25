import 'package:flutter/material.dart';

import '../widget/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 products per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                  imageUrl:
                      'https://rukminim3.flixcart.com/image/850/1000/xif0q/mobile/8/w/5/-original-imah4jyfwr3bfjbg.jpeg?q=90&crop=false',
                  title: 'iPhone 16',
                  brand: 'Apple',
                  oldPrice: 549.00,
                  newPrice: 477.85,
                  discount: 12.70);
            }),
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text('Catalogue'),
    centerTitle: true,
    actions: [
      IconButton(
          onPressed: () {},
          icon: Badge(
            label: Text("5"),
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
          ))
    ],
  );
}

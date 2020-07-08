import 'package:flutter/material.dart';
import './product_item.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    Provider.of(context)
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ProductItem(
        id: loadedProducts[index].id,
        imageUrl: loadedProducts[index].imageUrl,
        title: loadedProducts[index].title,
      ),
      itemCount: loadedProducts.length,
    );
  }
}

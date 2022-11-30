import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/widgets/products_list_card_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? imageUrl;
  final String? productTitle;
  final String? productPrice;
  final String? description;
  final String? rating;
  final String? count;

  const ProductDetailsScreen(
      { this.imageUrl,
      this.productTitle,
       this.productPrice,
       this.description,
       this.rating,
     this.count,
      Key? key})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductsListCardWidget(
          imageUrl: widget.imageUrl,
          productTitle: widget.productTitle,
          productPrice: widget.productPrice,
          description: widget.description,
          rating: widget.rating,
          count: widget.count,
        ),
      ),
    );
  }
}

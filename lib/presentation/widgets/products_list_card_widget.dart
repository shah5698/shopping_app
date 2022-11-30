import 'package:flutter/material.dart';

class ProductsListCardWidget extends StatelessWidget {
  const ProductsListCardWidget({
    this.imageUrl,
    this.productTitle,
    this.productPrice,
    this.description,
    this.rating,
    this.count,
    this.onPress,
    Key? key,
  }) : super(key: key);

  final String? imageUrl;
  final String? productTitle;
  final String? productPrice;
  final String? description;
  final String? rating;
  final String? count;
  final void Function()? onPress;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          child: Column(
            children: [
              ClipRect(
                child: Image.network(imageUrl!,
                    // width: 300,
                    height: 150,
                    fit: BoxFit.fill),
              ),
              ListTile(
                title: Text(productTitle!),
                subtitle: Text(productPrice!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

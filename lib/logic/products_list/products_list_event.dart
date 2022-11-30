import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ProductsListEvent {
  const ProductsListEvent();
}

class ProductsListLoadEvent extends ProductsListEvent {
  const ProductsListLoadEvent();
}

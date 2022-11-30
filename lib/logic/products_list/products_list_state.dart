import 'package:flutter/foundation.dart' show immutable;

import 'package:equatable/equatable.dart';

import '/data/model/products_list/products_list_response_model.dart';



@immutable
abstract class ProductsListState extends Equatable {
  const ProductsListState({this.productList});
  final  List<ProductsListResponseModel>? productList;

  @override
  List<Object?> get props => [productList];
}

class ProductsListInitialState extends ProductsListState {
  const ProductsListInitialState();
}

class ProductsListIsLoadingState extends ProductsListState {
  const ProductsListIsLoadingState();
}

class ProductsListSuccessState extends ProductsListState {
  const ProductsListSuccessState({required List<ProductsListResponseModel> productList}) : super(productList: productList);

  @override
  List<Object?> get props => [productList];
}

class ProductsListFailureState extends ProductsListState {
  final String errorMessage;
  const ProductsListFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

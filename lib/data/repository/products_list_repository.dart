import 'package:shopping_app/data/provider/remote_provider/product_list_api.dart';

import '../model/products_list/products_list_response_model.dart';

class ProductsListRepository {
  Future<List<ProductsListResponseModel>?> getProductsData() async {
    final rawData = await ProductsListApi.getRawData();
    if (rawData.statusCode >= 200 && rawData.statusCode <= 399) {
      return productsListResponseModelFromJson(rawData.body);
    } else {
      return null;
    }
  }
}

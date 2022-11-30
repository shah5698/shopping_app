import 'package:bloc/bloc.dart';
import 'package:shopping_app/data/repository/products_list_repository.dart';
import 'package:shopping_app/logic/products_list/products_list_event.dart';
import 'package:shopping_app/logic/products_list/products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc() : super(const ProductsListInitialState()) {
    on<ProductsListLoadEvent>((event, emit) async {
     emit(const ProductsListIsLoadingState());
     final ProductsListRepository repository = ProductsListRepository();
     final result = await repository.getProductsData();
     if(result == null){
       emit(const ProductsListFailureState(errorMessage: "Date is not there"));
     }else{
       emit(const ProductsListIsLoadingState());
       emit(ProductsListSuccessState(productList: result));
     }
    });
  }
}

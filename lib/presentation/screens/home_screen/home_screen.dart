import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/logic/products_list/products_list_event.dart';
import 'package:shopping_app/presentation/widgets/products_list_card_widget.dart';
import '../../../app_localization.dart';
import '../../../logic/products_list/products_list_bloc.dart';
import '../../../logic/products_list/products_list_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductsListBloc productsListBloc;

  @override
  void initState() {
    super.initState();
    productsListBloc = BlocProvider.of<ProductsListBloc>(context);
    productsListBloc.add(const ProductsListLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsListBloc, ProductsListState>(
      listener: (context, productsListState) {
        if (productsListState is ProductsListFailureState) {
          AwesomeDialog(
            context: context,
            isDense: false,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(AppLocalization.of(context)
                  .getTranslatedValues("someThingWentWrong")),
            ),
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, productsListState) {
        if (productsListState is ProductsListIsLoadingState) {
          return const SizedBox.shrink();
        } else if (productsListState is ProductsListSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Shopping App"),
            ),
            body: ListView.builder(
              itemCount: productsListState.productList?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ProductsListCardWidget(
                      imageUrl: productsListState.productList![index].image
                          .toString(),
                      productTitle: productsListState.productList![index].title
                          .toString(),
                      productPrice: productsListState.productList![index].price
                          .toString(),
                    ));
              },
            ),
          );
        } else if (productsListState is ProductsListFailureState) {
          return const Scaffold(
              body: Center(child: Text("something went wrong")));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/fertilizer_model.dart';
import '../../../models/plant_model.dart';
import '../../utils/colors.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  List<dynamic> cartItems = [];
  num price = 0;

  bool isloading = false;
  // for (var element in value.docs) {
  // var product = await element.data()['reference'].get();
  // cartProducts.add(ProductsModel.fromJson(product.data()));
  // price += int.parse(product.data()['price']);
  // }

  void getCartItems() async {
    print("dsds");

    isloading = true;
    emit(GetCartItemsLoading());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection("cart")
        .get()
        .then((value) async {
      cartItems.clear();
      price = 0;
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> document = await element.data()['reference'];
        QuerySnapshot<Map<String, dynamic>> isFav = await FirebaseFirestore.instance
            .collection("users")
            .doc(Constants.userModel!.id)
            .collection("favourite")
            .where("reference", isEqualTo: element.data()['reference'])
            .get();

        print(
          document.path.split("/").first,
        );
        await document.get().then((value) {
          price += value.data()!['price'];
          if (document.path.split("/").first == "fertilizer") {
            cartItems.add(
                FertilizerModel.fromJson(value.data(), isCart: true, isFavorated: isFav.docs.isNotEmpty));
          } else {
            cartItems
                .add(PlantModel.fromJson(value.data(), isCart: true, isFavorated: isFav.docs.isNotEmpty));
          }
        });
      }
      isloading = false;
      emit(GetCartItemsSuccess());
    });
  }
}

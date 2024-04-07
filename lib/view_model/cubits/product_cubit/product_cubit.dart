import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/colors.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);
  void addToFav(DocumentReference reference) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection('favourite')
        .doc(reference.id)
        .set({'reference': reference}).then((value) {
      emit(PlantAddedToFav());
    });
  }
  void removeFromFav(DocumentReference reference){
    FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection('favourite')
        .doc(reference.id)
        .delete();
    emit(removedFromFav());

  }


  void addToCart(DocumentReference reference) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection('cart')
        .doc(reference.id)
        .set({'reference': reference}).then((value) {
      emit(AddToCart());
    });
  }
  void removeFromCart(DocumentReference reference){
    FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection('cart')
        .doc(reference.id)
        .delete();

    emit(removedFromCart());

  }


}

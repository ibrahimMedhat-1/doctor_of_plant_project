import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_of_plant_project/models/fertilizer_model.dart';
import 'package:doctor_of_plant_project/models/plant_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/colors.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  static FavouritesCubit get(context) => BlocProvider.of(context);
  List<dynamic> favItems = [];

  void getFavItems() async {
    print("dsds");
    emit(GetFavItemsLoading());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection("favourite")
        .get()
        .then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> document =
            await element.data()['reference'];
        QuerySnapshot<Map<String, dynamic>> isCart = await FirebaseFirestore.instance.collection("users").
        doc(Constants.userModel!.id)
            .collection("cart")
            .where("reference",isEqualTo: element.data()['reference']).get();
        print(
          document.path.split("/").first,
        );
        await document.get().then((value) {
          if (document.path.split("/").first == "fertilizer") {
            favItems.add(FertilizerModel.fromJson(value.data(),isFavorated: true,isCart: isCart.docs.isNotEmpty));
          } else {
            favItems.add(PlantModel.fromJson(value.data(),isFavorated: true,isCart: isCart.docs.isNotEmpty));
          }
        });
      }
      emit(GetFavItemsSuccess());
    });
  }
}

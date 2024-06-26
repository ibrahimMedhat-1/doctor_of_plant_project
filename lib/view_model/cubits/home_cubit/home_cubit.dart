import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/data_set_model.dart';
import '../../../models/fertilizer_model.dart';
import '../../../models/plant_model.dart';
import '../../utils/colors.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<PlantModel> plantsShowList = [];
  List<PlantModel> plants = [];
  List<PlantModel> plantsSearch = [];
  List<FertilizerModel> fertilizersShowList = [];
  List<FertilizerModel> fertilizers = [];
  List<FertilizerModel> fertilizersSearch = [];
  List<DataSetModel> dataSetList = [];

  void getFertilizers() {
    emit(GetAllFertilizersLoading());
    FirebaseFirestore.instance.collection('fertilizer').get().then((value) async {
      fertilizers.clear();
      for (var element in value.docs) {
        QuerySnapshot<Map<String, dynamic>> isFav = await FirebaseFirestore.instance
            .collection("users")
            .doc(Constants.userModel!.id)
            .collection("favourite")
            .where("reference", isEqualTo: element.data()["ref"])
            .get();
        QuerySnapshot<Map<String, dynamic>> isCart = await FirebaseFirestore.instance
            .collection("users")
            .doc(Constants.userModel!.id)
            .collection("cart")
            .where("reference", isEqualTo: element.data()["ref"])
            .get();

        fertilizers.add(FertilizerModel.fromJson(element.data(),
            isFavorated: isFav.docs.isNotEmpty, isCart: isCart.docs.isNotEmpty));
      }
      emit(GetAllFertilizersSuccessfully());
    }).catchError((onError) {
      emit(GetAllFertilizersError());
      print(onError);
    });
  }

  void getPlants() {
    print('element.data()');

    emit(GetAllPlantsLoading());
    FirebaseFirestore.instance.collection('plants').get().then((value) async {
      plants.clear();
      for (var element in value.docs) {
        QuerySnapshot<Map<String, dynamic>> isFav = await FirebaseFirestore.instance
            .collection("users")
            .doc(Constants.userModel!.id)
            .collection("favourite")
            .where("reference", isEqualTo: element.data()["ref"])
            .get();
        QuerySnapshot<Map<String, dynamic>> isCart = await FirebaseFirestore.instance
            .collection("users")
            .doc(Constants.userModel!.id)
            .collection("cart")
            .where("reference", isEqualTo: element.data()["ref"])
            .get();

        plants.add(PlantModel.fromJson(element.data(),
            isFavorated: isFav.docs.isNotEmpty, isCart: isCart.docs.isNotEmpty));
      }
      emit(GetAllPlantsSuccessfully());
    }).catchError((onError) {
      emit(GetAllPlantsError());
      print(onError);
    });
  }
  void getDataSets() {
    emit(GetDataSetLoading());
    FirebaseFirestore.instance
        .collection('dataSet')
        .get()
        .then((value) async {
      dataSetList.clear();
      for (var element in value.docs) {
        dataSetList.add(DataSetModel.fromJson(element.data(),));
      }
      emit(GetDataSet());
    }).catchError((onError) {});
  }


  void addToCart(DocumentReference reference) async {
    emit(AddPlantToCartLoading());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection('cart')
        .doc(reference.id)
        .set({'reference': reference}).then((value) {
      emit(PlantAddedToCart());
    });
  }

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

  void removeFromFav(DocumentReference reference) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .collection('favourite')
        .doc(reference.id)
        .delete();
    emit(removedFromFav());
  }

  TextEditingController searchController = TextEditingController();
  void search(String value) {
    emit(IsSearching());
    fertilizersSearch.clear();
    plantsSearch.clear();
    for (FertilizerModel fertilizerModel in fertilizers) {
      if (fertilizerModel.name.toString().toLowerCase().contains(value.toLowerCase())) {
        fertilizersSearch.add(fertilizerModel);
      }
    }
    for (PlantModel plantModel in plants) {
      if (plantModel.name.toString().toLowerCase().contains(value.toLowerCase())) {
        plantsSearch.add(plantModel);
      }
    }
    emit(IsSearching());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/fertilizer_model.dart';
import '../../../models/plant_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<PlantModel> plants = [];
  List<FertilizerModel> fertilizers = [];

  void getFertilizers() {
    emit(GetAllFertilizersLoading());
    FirebaseFirestore.instance.collection('fertilizer').get().then((value) {
      fertilizers.clear();
      for (var element in value.docs) {
        fertilizers.add(FertilizerModel.fromJson(element.data()));
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
    FirebaseFirestore.instance.collection('plants').get().then((value) {
      plants.clear();
      for (var element in value.docs) {
        plants.add(PlantModel.fromJson(element.data()));
      }
      emit(GetAllPlantsSuccessfully());
    }).catchError((onError) {
      emit(GetAllPlantsError());
      print(onError);
    });
  }
}

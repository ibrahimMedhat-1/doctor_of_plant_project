import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());
  static ScanCubit get(context) => BlocProvider.of(context);
  String scanImage = '';
  Future<void> pickImageFromGallery() async {
    emit(UploadImageLoading());
    if (kIsWeb) {
      await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
        final image = await value!.readAsBytes();
        await FirebaseStorage.instance
            .ref()
            .child('Scan')
            .putData(
              image,
              SettableMetadata(contentType: 'image/png'),
            )
            .then((p0) async {
          await p0.ref.getDownloadURL().then((value) async {
            await FirebaseFirestore.instance.collection('scan').doc("scanImage").set({'image': value});
            scanImage = value;
            print(scanImage);
            emit(UploadImage());
          });
        });
      });
    } else {
      final picker = ImagePicker();

      await picker.pickImage(source: ImageSource.gallery).then((value) async {
        emit(UploadImageLoading());

        FirebaseStorage.instance.ref().child('Scan').putFile(File(value!.path.toString())).then((value) {
          value.ref.getDownloadURL().then((value) async {
            await FirebaseFirestore.instance.collection('scan').doc("scanImage").set({'image': value});
            scanImage = value;
            emit(UploadImage());
          });
        });
      });
    }
  }

  List? outputs;
  bool loading = false;
  // Future<void> loadLungModel() async {
  //   loading = true;
  //   await Tflite.loadModel(
  //           model: 'assets/Lung_Cancer_ai_model/model_unquant.tflite',
  //           labels: 'assets/Lung_Cancer_ai_model/labels.txt')
  //       .then((value) {
  //     emit(LoadModelSuccess());
  //   }).catchError((onError) {
  //     debugPrint('load error');
  //     debugPrint(onError.toString());
  //     emit(LoadModelError());
  //   });
  // }

// cubit.outputs![0]['label'] == '0 Cancerous'
//   classifyLungImage(File image, userHistoryId, userId) async {
//     await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 2,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     ).then((value) {
//       debugPrint(value.toString());
//       loading = false;
//       outputs = value;
//       Tflite.close();
//       emit(ClassifySuccess());
//     }).catchError((onError) {
//       debugPrint('error classify');
//       debugPrint(onError.toString());
//       Tflite.close();
//       emit(ClassifyError());
//     });
//     Tflite.close();
//   }
}

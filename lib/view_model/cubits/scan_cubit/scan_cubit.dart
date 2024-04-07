import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constants.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());
  static ScanCubit get(context) => BlocProvider.of(context);

  Future<void> pickImageFromGallery() async {
    if (kIsWeb) {
      emit(UploadImageLoading());
      await ImagePicker()
          .pickImage(source: ImageSource.gallery)
          .then((value) async {
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
            await FirebaseFirestore.instance
                .collection('scan')
                .doc("scanImage")
                .set({'image': value});
            scanImage = value;

              emit(UploadImage());

          });
        });
      });
    } else {
      final picker = ImagePicker();

      await picker.pickImage(source: ImageSource.gallery).then((value) async {
        emit(UploadImageLoading());

        FirebaseStorage.instance
            .ref()
            .child('Scan')
            .putFile(File(value!.path.toString()))
            .then((value) {
          value.ref.getDownloadURL().then((value) async {

            await FirebaseFirestore.instance
                .collection('scan')
                    .doc("scanImage")
                    .set({'image': value});
            scanImage = value;
          });
        });

        emit(UploadImage());
      });
    }
  }
}

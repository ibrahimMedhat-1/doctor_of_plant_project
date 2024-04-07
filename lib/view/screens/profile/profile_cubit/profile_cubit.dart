import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_of_plant_project/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../view_model/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();

  void initialize() {
    nameController.text = Constants.userModel!.name!;
  }

  void updateName(BuildContext context) async {
    emit(ChangeInformationLoading());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .update({
      'name': nameController.text.toString(),
    });
    Constants.userModel!.name = nameController.text.toString();
    await getMyData();
    emit(ChangeInformation());
    Navigator.pop(context);
  }

  void showImagePicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                            color: Constants.primaryColor,
                          ),
                          const Text(
                            'Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () async {
                        await pickImageFromGallery();
                      },
                    )),
                  ],
                )),
          );
        });
  }

  String? path;

  Future<void> pickImageFromGallery() async {
    if (kIsWeb) {
      await ImagePicker()
          .pickImage(source: ImageSource.gallery)
          .then((value) async {
        final image = await value!.readAsBytes();
        await FirebaseStorage.instance
            .ref()
            .child('ProfileImage/${Constants.userModel!.id!}')
            .putData(
              image,
              SettableMetadata(contentType: 'image/png'),
            )
            .then((p0) async {
          await p0.ref.getDownloadURL().then((value) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(Constants.userModel!.id!)
                .update({'image': value}).then((value) async {
              profileImage = Constants.userModel!.image!;
              print(profileImage);
              emit(ChangeImage());
            });
          });
        });
      });
    } else {
      final picker = ImagePicker();

      await picker.pickImage(source: ImageSource.gallery).then((value) async {
        emit(ChangeImageLoading());
        FirebaseStorage.instance
            .ref()
            .child('ProfileImage/${Constants.userModel!.id!}')
            .putFile(File(value!.path.toString()))
            .then((value) {
          value.ref.getDownloadURL().then((value) async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(Constants.userModel!.id!)
                .update({'image': value});
          });
        });
        await getMyData();
        emit(ChangeImage());
      });
    }
  }

  Future<void> getMyData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .get()
        .then((value) {
      Constants.userModel = UserModel.fromJson(value.data());
      emit(GetMYData());
    });
  }

  String profileImage = Constants.userModel?.image ?? '';

}

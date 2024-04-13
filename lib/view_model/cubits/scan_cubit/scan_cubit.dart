import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:doctor_of_plant_project/shared/network/end_points.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/network/remote/dio_helper.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  static ScanCubit get(context) => BlocProvider.of(context);
  String scanImage = '';
  File? imageFile;
  Future<void> pickImageFromGallery() async {
    emit(UploadImageLoading());
    if (kIsWeb) {
      await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
        final image = await value!.readAsBytes();
        // await detectImageWeb(image);
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
        imageFile = File(value!.path);
        emit(UploadImage());
        await detectImage(File(value.path));

        // FirebaseStorage.instance.ref().child('Scan').putFile(File(value!.path.toString())).then((value) {
        //   value.ref.getDownloadURL().then((value) async {
        //     await FirebaseFirestore.instance.collection('scan').doc("scanImage").set({'image': value});
        //     scanImage = value;
        //   });
        // });
      });
    }
  }

  String disease = '';
  Future<void> detectImage(File file) async {
    var response = await DioHelper.postData(
      url: baseUrl,
      data: FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      }),
    );
    //
    // var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    // request.fields['image'] = 'image';
    // var image = http.MultipartFile.fromBytes(
    //   'image',
    //   (await file.readAsBytes()).buffer.asUint8List(),
    //   filename: file.path.split('/').last,
    // );
    // request.files.add(image);
    // var response = await request.send();
    // var responseData = await response.stream.toBytes();
    //
    disease = response.data['class'];
    emit(DetectPlantDisease());
    // print(response.data['class']);
  }

  // Future<void> detectImageWeb(Uint8List imageBytes) async {
  //   // html.File? file;
  //   // final formData = html.FormData();
  //   // formData.appendBlob('image', file);
  //   // var response = await http.post(Uri.parse(baseUrl), body: FormData.fromMap({
  //   //       'image': await MultipartFile.fromFile(
  //   //         imageFilePath,
  //   //         filename: imageFilePath.split('/').last,
  //   //       ),
  //   //     }),);
  //   // print(response.body);
  //   // final request = html.HttpRequest();
  //   // request.open('POST', baseUrl);
  //   // request.send(formData);
  //   // request.onLoad.listen((event) {
  //   //   print('cghvjbknlm;');
  //   //   Handle the API response here
  //   // if (request.status == 200) {
  //   //   print('File uploaded successfully');
  //   // } else {
  //   //   print('Error: ${request.statusText}');
  //   // }
  //   // });
  //
  //   // html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   // uploadInput.accept = 'png/jpg/jpeg'; // Specify the accepted file types
  //   // uploadInput.multiple = false; // Allow multiple file selection if needed
  //   // uploadInput.click();
  //
  //   // uploadInput.onChange.listen((e) async {
  //   //   final List<html.File> files = await uploadInput.files!;
  //   //   if (files.isNotEmpty) {
  //   //     file = files.first;
  //   //     var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
  //   //     request.fields['image'] = 'image';
  //   //     File file2 = File(file!.relativePath!);
  //   //     var image = await http.MultipartFile.fromBytes(
  //   //       'image',
  //   //       imageBytes,
  //   //       filename: 'image.jpg',
  //   //     );
  //   //     request.files.add(image);
  //   //
  //   //     var response = await request.send().catchError((onError) {
  //   //       print(onError);
  //   //     });
  //   //     print('hjbknlm1');
  //   //     var responseData = await response.stream.toBytes();
  //   //
  //   //     disease = String.fromCharCodes(responseData);
  //   //     emit(DetectPlantDisease());
  //   //     print('====>>> $disease');
  //   //   } else {
  //   //     print('sdfghjk');
  //   //   }
  //   // });
  //
  //   // file = files.first;
  //   var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
  //   request.fields['image'] = 'image';
  //   // File file2 = File(file!.relativePath!);
  //   var image = http.MultipartFile.fromBytes(
  //     'image',
  //     imageBytes,
  //     filename: 'image.jpg',
  //   );
  //   request.files.add(image);
  //   print('hdjkdsl');
  //   try {
  //     var response = await request.send();
  //     var responseData = await response.stream.toBytes();
  //     print(responseData);
  //     disease = String.fromCharCodes(responseData);
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   emit(DetectPlantDisease());
  //   print('====>>> $disease');
  // }
}

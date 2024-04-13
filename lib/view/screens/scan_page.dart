import 'package:doctor_of_plant_project/view_model/cubits/scan_cubit/scan_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ScanCubit(),
      child: BlocConsumer<ScanCubit, ScanState>(
        listener: (context, state) {},
        builder: (context, state) {
          final ScanCubit cubit = ScanCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Constants.primaryColor.withOpacity(.15),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: 100,
                  right: 20,
                  left: 20,
                  child: Container(
                    width: size.width * .8,
                    height: size.height * .8,
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          state is UploadImageLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : kIsWeb
                                  ? cubit.scanImage.isNotEmpty
                                      ? Image.network(
                                          cubit.scanImage,
                                          height: 300,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                        )
                                      : const Text("No Image Selected")
                                  : cubit.imageFile != null
                                      ? Image.file(cubit.imageFile!)
                                      : const Text("No Image Selected"),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              onTap: () {
                                cubit.pickImageFromGallery();
                              },
                              child: Container(
                                width: size.width * 0.6,
                                decoration: BoxDecoration(
                                  color: Constants.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                child: const Center(
                                  child: Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            cubit.disease,
                            style: TextStyle(
                              color: Constants.primaryColor.withOpacity(.80),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String imageUrl;

  const MyImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Text('Error loading image'),
        );
      },
    );
  }
}

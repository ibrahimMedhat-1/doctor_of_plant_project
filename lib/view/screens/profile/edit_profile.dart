import 'package:doctor_of_plant_project/view/screens/profile/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/utils/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;

        final ProfileCubit cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
          ),
          body: ListView(
            children: [
              state is ChangeImageLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Stack(
                        children: [
                          Container(
                              width: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Constants.primaryColor.withOpacity(.5),
                                  width: 5.0,
                                ),
                              ),
                              child: cubit.userModel == null
                                  ? const CircleAvatar(
                                      radius: 60,
                                      backgroundImage: ExactAssetImage('assets/images/profile.png'),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(cubit.userModel!.image.toString()),
                                    )),
                          Container(
                            color: Constants.primaryColor,
                            child: IconButton(
                              onPressed: () {
                                cubit.showImagePicker(context);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: cubit.nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              state is ChangeInformationLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        cubit.updateName(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: const Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

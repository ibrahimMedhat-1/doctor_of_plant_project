import 'package:doctor_of_plant_project/view/screens/profile/profile_cubit/profile_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../components/profile_widget.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit.get(context).getMyData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Constants.userModel!.image == ""
                      ? const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              ExactAssetImage('assets/images/profile.png'),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              Constants.userModel!.image.toString()),
                        )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constants.userModel!.name.toString(),
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                        height: 20,
                        child: Image.asset("assets/images/verified.png")),
                  ],
                ),
              ),
              Text(
                Constants.userModel!.email.toString(),
                style: TextStyle(
                  color: Constants.blackColor.withOpacity(.3),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: size.height * .7,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfile(),
                              ));
                        },
                        icon: Icons.person,
                        title: 'My Profile'),
                    ProfileWidget(
                      onTap: () {},
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

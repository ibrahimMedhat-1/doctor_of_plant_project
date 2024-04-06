import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';

import '../components/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .3,
                child: Row(
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'My Profile',
                    ),
                    ProfileWidget(
                      icon: Icons.settings,
                      title: 'Settings',
                    ),
                    ProfileWidget(
                      icon: Icons.notifications,
                      title: 'Notifications',
                    ),
                    ProfileWidget(
                      icon: Icons.chat,
                      title: 'FAQs',
                    ),
                    ProfileWidget(
                      icon: Icons.share,
                      title: 'Share',
                    ),
                    ProfileWidget(
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

import 'package:doctor_of_plant_project/models/plants.dart';
import 'package:doctor_of_plant_project/view/components/plant_widget.dart';
import 'package:doctor_of_plant_project/view/screens/detail_screen.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:doctor_of_plant_project/view_model/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SupplementScreen extends StatefulWidget {
  const SupplementScreen({Key? key}) : super(key: key);

  @override
  State<SupplementScreen> createState() => _SupplementScreenState();
}

class _SupplementScreenState extends State<SupplementScreen> {
  List<Plant> plantList = Plant.plantList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        title: const Text('Supplement'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.black12),
                  ),
                ),
                elevation: const MaterialStatePropertyAll(0),
                leading: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search supplement',
                hintStyle: const MaterialStatePropertyAll(
                  TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigation.push(
                      context,
                      PageTransition(
                        child: DetailPage(
                          plantId: plantList[index].plantId,
                        ),
                        type: PageTransitionType.bottomToTop,
                      ) as Widget,
                    );
                  },
                  child: PlantWidget(
                    index: index,
                    plantList: plantList,
                  ),
                );
              },
              childCount: plantList.length,
            ),
          ),
        ],
      ),
    );
  }
}

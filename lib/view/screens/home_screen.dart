import 'package:doctor_of_plant_project/view/screens/chat_screens/chat_screen.dart';
import 'package:doctor_of_plant_project/view/screens/full_image_view.dart';
import 'package:doctor_of_plant_project/view_model/cubits/home_cubit/home_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:doctor_of_plant_project/view_model/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../components/plant_widget.dart';
import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    //Plants category
    List<String> plantTypes = [
      // 'Recommended',
      // // 'Indoor',
      // // 'Outdoor',
      // // 'Garden',
      // '-------------------',
      'Supplement',
    ];

    return BlocProvider(
      create: (context) => HomeCubit()
        ..getPlants()
        ..getFertilizers()
        ..getDataSets(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is IsSearching) {
            HomeCubit.get(context).fertilizersShowList = HomeCubit.get(context).fertilizersSearch;
            HomeCubit.get(context).plantsShowList = HomeCubit.get(context).plantsSearch;
          } else {
            HomeCubit.get(context).fertilizersShowList = HomeCubit.get(context).fertilizers;
            HomeCubit.get(context).plantsShowList = HomeCubit.get(context).plants;
          }
        },
        builder: (context, state) {
          print('object');
          final HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          width: size.width * .9,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black54.withOpacity(.6),
                              ),
                              Expanded(
                                  child: TextField(
                                showCursor: false,
                                controller: cubit.searchController,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    cubit.emit(IsNotSearching());
                                  } else {
                                    cubit.search(value);
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search Plant',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              )),
                              // Icon(
                              //   Icons.mic,
                              //   color: Colors.black54.withOpacity(.6),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50.0,
                    width: size.width,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: plantTypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Text(
                                plantTypes[index],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.w300,
                                  color:
                                      selectedIndex == index ? Constants.primaryColor : Constants.blackColor,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: size.height * .3,
                    child: ListView.builder(
                        itemCount: cubit.fertilizersShowList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: DetailPage(
                                        fertilizerModel: cubit.fertilizersShowList[index],
                                      ),
                                      type: PageTransitionType.bottomToTop));
                            },
                            child: Container(
                              width: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Constants.primaryColor.withOpacity(.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    right: 20,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (cubit.fertilizersShowList[index].isFavorated) {
                                                cubit.removeFromFav(cubit.fertilizersShowList[index].ref!);
                                              } else {
                                                cubit.addToFav(cubit.fertilizersShowList[index].ref!);
                                              }
                                              cubit.fertilizersShowList[index].isFavorated =
                                                  !cubit.fertilizersShowList[index].isFavorated;
                                            });
                                          },
                                          icon: Icon(
                                            cubit.fertilizersShowList[index].isFavorated
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Constants.primaryColor,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    left: 50,
                                    right: 50,
                                    top: 50,
                                    bottom: 50,
                                    child: Image.network(cubit.fertilizersShowList[index].image ?? ''),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.fertilizersShowList[index].type ?? '',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          cubit.fertilizersShowList[index].name ?? '',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    right: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        r'$' + cubit.fertilizersShowList[index].price.toString(),
                                        style: TextStyle(color: Constants.primaryColor, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                    child: const Text(
                      'New Plants',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.plantsShowList.length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        print(cubit.plantsShowList.length);
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: DetailPage(plant: cubit.plantsShowList[index]),
                                      type: PageTransitionType.bottomToTop));
                            },
                            child: PlantWidget(index: index, plantList: cubit.plantsShowList));
                      }),
                  Container(
                    padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                    child: const Text(
                      'Data Sets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .2,
                    child: ListView.builder(
                        itemCount: cubit.dataSetList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullImageView(imageUrl: cubit.dataSetList[index].image.toString()),
                                    ));
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Constants.primaryColor.withOpacity(.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.12,
                                        child: Image(
                                            image: NetworkImage(cubit.dataSetList[index].image.toString())),
                                      ),
                                      Text(cubit.dataSetList[index].name.toString())
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigation.push(context, const ChatScreen());
              },
              backgroundColor: Constants.primaryColor,
              child: const Icon(
                Icons.chat,
                color: Colors.white,
              ), // Set the background color
            ),
          );
        },
      ),
    );
  }
}

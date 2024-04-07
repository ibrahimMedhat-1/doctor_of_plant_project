import 'package:doctor_of_plant_project/view_model/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/plant_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FavouritesCubit.get(context).getFavItems();
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<FavouritesCubit, FavouritesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final FavouritesCubit cubit = FavouritesCubit.get(context);
        return Scaffold(
            body: state is GetFavItemsLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.favItems.isNotEmpty
                    ? SizedBox(
                        height: 900,
                        child: ListView.builder(
                            itemCount: cubit.favItems.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return PlantWidget(index: index, plantList: cubit.favItems);
                            }),
                      )
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Image.asset('assets/images/favorited.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Your favourite Plants',
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ));
      },
    );
  }
}

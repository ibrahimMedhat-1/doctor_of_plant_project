import 'package:doctor_of_plant_project/models/fertilizer_model.dart';
import 'package:doctor_of_plant_project/models/plant_model.dart';
import 'package:doctor_of_plant_project/view/screens/cart_screen.dart';
import 'package:doctor_of_plant_project/view_model/cubits/cart_cubit/cart_cubit.dart';
import 'package:doctor_of_plant_project/view_model/cubits/product_cubit/product_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:doctor_of_plant_project/view_model/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final PlantModel? plant;
  final FertilizerModel? fertilizerModel;

  const DetailPage({super.key, this.plant, this.fertilizerModel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final ProductCubit cubit = ProductCubit.get(context);
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
                          Navigation.pop(context);
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
                      GestureDetector(
                        onTap: () {
                          debugPrint('favorite');
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Constants.primaryColor.withOpacity(.15),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  widget.fertilizerModel == null
                                      ? setState(() {
                                          if (widget.plant!.isFavorated) {
                                            cubit.removeFromFav(widget.plant!.ref!, context);
                                          } else {
                                            cubit.addToFav(widget.plant!.ref!, context);
                                          }
                                          widget.plant!.isFavorated = !widget.plant!.isFavorated;
                                        })
                                      : setState(() {
                                          if (widget.fertilizerModel!.isFavorated) {
                                            cubit.removeFromFav(widget.fertilizerModel!.ref!, context);
                                          } else {
                                            cubit.addToFav(widget.fertilizerModel!.ref!, context);
                                          }
                                          widget.fertilizerModel!.isFavorated =
                                              !widget.fertilizerModel!.isFavorated;
                                        });
                                },
                                icon: widget.fertilizerModel == null
                                    ? Icon(
                                        widget.plant!.isFavorated ? Icons.favorite : Icons.favorite_border,
                                        color: Constants.primaryColor,
                                      )
                                    : Icon(
                                        widget.fertilizerModel!.isFavorated
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Constants.primaryColor,
                                      ))),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: size.width * .8,
                    height: size.height * .8,
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 0,
                          child: SizedBox(
                            height: 350,
                            child: Image.network(widget.fertilizerModel == null
                                ? widget.plant!.image!
                                : widget.fertilizerModel!.image!),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 0,
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (widget.plant != null)
                                  PlantFeature(
                                    title: 'Size',
                                    plantFeature: widget.plant!.size!,
                                  ),
                                if (widget.plant != null)
                                  PlantFeature(
                                    title: 'Humidity',
                                    plantFeature: widget.plant!.humidity!,
                                  ),
                                if (widget.plant != null)
                                  PlantFeature(
                                    title: 'Temperature',
                                    plantFeature: widget.plant!.temperature!,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                    height: size.height * .5,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.4),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.fertilizerModel == null
                                      ? widget.plant!.name!
                                      : widget.fertilizerModel!.name!,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  " ${widget.fertilizerModel == null ? widget.plant!.price! : widget.fertilizerModel!.price!}",
                                  style: TextStyle(
                                    color: Constants.blackColor,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       widget.plant.rating.toString(),
                            //       style: TextStyle(
                            //         fontSize: 30.0,
                            //         color: Constants.primaryColor,
                            //       ),
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       size: 30.0,
                            //       color: Constants.primaryColor,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.fertilizerModel == null
                                ? widget.plant!.decription!
                                : widget.fertilizerModel!.description!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 18,
                              color: Constants.blackColor.withOpacity(.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: SizedBox(
              width: size.width * .9,
              height: 50,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: Constants.primaryColor.withOpacity(.3),
                          ),
                        ]),
                    child: IconButton(
                      onPressed: () {
                        widget.fertilizerModel == null
                            ? setState(() {
                                if (widget.plant!.isCart) {
                                  cubit.removeFromCart(widget.plant!.ref!);
                                  CartCubit.get(context).getCartItems();
                                } else {
                                  cubit.addToCart(widget.plant!.ref!);
                                  CartCubit.get(context).getCartItems();
                                }
                                widget.plant!.isCart = !widget.plant!.isCart;
                              })
                            : setState(() {
                                if (widget.fertilizerModel!.isCart) {
                                  cubit.removeFromCart(widget.fertilizerModel!.ref!);
                                  CartCubit.get(context).getCartItems();
                                } else {
                                  cubit.addToCart(widget.fertilizerModel!.ref!);
                                  CartCubit.get(context).getCartItems();
                                }
                                widget.fertilizerModel!.isCart = !widget.fertilizerModel!.isCart;
                              });
                      },
                      icon: widget.fertilizerModel == null
                          ? Icon(
                              Icons.shopping_cart,
                              color: widget.plant!.isCart == true ? Constants.primaryColor : Colors.grey,
                            )
                          : Icon(
                              Icons.shopping_cart,
                              color: widget.fertilizerModel!.isCart == true
                                  ? Constants.primaryColor
                                  : Colors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: Constants.primaryColor.withOpacity(.3),
                              )
                            ]),
                        child: const Center(
                          child: Text(
                            'BUY NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;

  const PlantFeature({
    super.key,
    required this.plantFeature,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

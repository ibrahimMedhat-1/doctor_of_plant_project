import 'package:doctor_of_plant_project/models/plant_model.dart';
import 'package:doctor_of_plant_project/view_model/cubits/cart_cubit/cart_cubit.dart';
import 'package:doctor_of_plant_project/view_model/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/plant_widget.dart';

class CartPage extends StatelessWidget {


  const CartPage({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit.get(context).getCartItems();
    Size size = MediaQuery
        .of(context)
        .size;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final CartCubit cubit = CartCubit.get(context);
        return Scaffold(
          body:  state is GetCartItemsLoading?
         const Center(
            child: CircularProgressIndicator(),
          ):
              cubit.cartItems.isNotEmpty?
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cubit.cartItems.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return PlantWidget(
                            index: index,
                            plantList: cubit.cartItems);
                      }),
                ),
                Column(
                  children: [
                    const Divider(
                      thickness: 1.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Totals',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          cubit.price.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ):
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset('assets/images/add-cart.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Cart is Empty',
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),






        );
      },
    );
  }
}

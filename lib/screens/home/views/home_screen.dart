import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import '../../cart/views/cart_screen.dart';
import '../blocs/get_food_bloc/get_food_bloc.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Image.asset('assets/8.png', scale: 30),
            const SizedBox(width: 8),
            const Text(
              'Fast Food',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
          ],
        ),
        actions: [
          IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
          icon: const Icon(CupertinoIcons.cart),
        ),


          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
      body: BlocBuilder<GetFoodBloc, GetFoodState>(
        builder: (context, state) {
          if (state is GetFoodSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 16,
                  childAspectRatio: 8 / 16, // Adjust as needed for proper aspect ratio
                ),
                itemCount: state.foods.length,
                itemBuilder: (context, int i) {
                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                DetailsScreen(state.foods[i]),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container for the image with a fixed aspect ratio
                          Container(
                            height: 150, // Set a fixed height or use a calculated height
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: state.foods[i].picture.isNotEmpty
                                    ? NetworkImage(state.foods[i].picture)
                                    : const AssetImage('assets/default_image.png')
                                as ImageProvider,
                                fit: BoxFit.cover, // Ensure the image covers the space
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: state.foods[i].isVeg
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Text(
                                      state.foods[i].isVeg ? "VEG" : "NON-VEG",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Text(
                                      state.foods[i].spicy == 1
                                          ? "🌶️ BLAND"
                                          : state.foods[i].spicy == 2
                                          ? "🌶️ BALANCE"
                                          : "🌶️ SPICY",
                                      style: TextStyle(
                                          color: state.foods[i].spicy == 1
                                              ? Colors.green
                                              : state.foods[i].spicy == 2
                                              ? Colors.orange
                                              : Colors.redAccent,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              state.foods[i].name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              state.foods[i].description,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\$${state.foods[i].price - (state.foods[i].price * (state.foods[i].discount) / 100)}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "\$${state.foods[i].price}.00",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(AddToCart(state.foods[i]));
                                  },
                                  icon: const Icon(CupertinoIcons.add_circled_solid),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is GetFoodLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("An error has occurred..."),
            );
          }
        },
      ),
    );
  }
}

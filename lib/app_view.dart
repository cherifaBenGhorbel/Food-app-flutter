import 'package:fast_food/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:fast_food/screens/auth/views/welcome_screen.dart';
import 'package:fast_food/screens/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:fast_food/screens/home/blocs/get_food_bloc/get_food_bloc.dart';
import 'package:fast_food/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_repository/food_repository.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Fast Food' ,
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.light(
                primary: Colors.amber,                   // Primary theme color
                onPrimary: Colors.white,                 // Text/icons on primary color
                surface: Colors.white,                   // Surface background
                onSurface: Colors.black,                 // Text/icons on surface
                tertiary: Colors.amber.shade100          // Decoration elements
            )
        ),

      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
            ),
            BlocProvider(
              create: (context) => GetFoodBloc(FirebaseFoodRepo())..add(GetFoods()),
            ),
            BlocProvider(
              create: (context) => CartBloc(),
            ),
          ],
          child: const HomeScreen(),
        );
      } else {
        return const WelcomeScreen();
      }
        }),
      ));
  }
}
import 'package:e_learning/src/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/values/colors.dart';
import '../bloc/base/base_cubit.dart';
import 'profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    context.read<BaseCubit>().resetFeature();
    super.initState();
  }

  final List<Widget> screenBody = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 32,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BlocBuilder<BaseCubit, BaseState>(
          builder: (context, state) {
            return NavigationBar(
              onDestinationSelected: context.read<BaseCubit>().changeFeature,
              indicatorColor: Colors.black.withOpacity(0.1),
              selectedIndex: state.featureIndex,
              destinations: [
                NavigationDestination(
                  icon: Image.asset(
                    'assets/images/home-icon.png',
                  ),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.person_2_rounded),
                  label: 'Profile',
                ),
              ],
              height: 70,
              elevation: 0,
              backgroundColor: Colors.white,
            );
          },
        ),
      ),
      body: BlocBuilder<BaseCubit, BaseState>(
        builder: (context, state) {
          return screenBody[state.featureIndex];
        },
      ),
    );
  }
}

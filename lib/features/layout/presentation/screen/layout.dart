import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_cubit.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.selectedIndex]),
          ),
          body: cubit.screen[cubit.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: cubit.selectedIndex,
            onDestinationSelected: (index) {
              cubit.changeScreen(index);
            },
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.task), label: 'Tasks'),
              NavigationDestination(icon: Icon(Iconsax.chart_success), label: 'Done'),
              NavigationDestination(icon: Icon(Iconsax.archive), label: 'Archived'),
            ],
          ),
        ),
    );
  }
}

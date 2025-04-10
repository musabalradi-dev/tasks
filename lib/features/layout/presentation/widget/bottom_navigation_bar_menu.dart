import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_cubit.dart';

class BottomNavigationBarMenu extends StatelessWidget {
  const BottomNavigationBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return NavigationBar(
      selectedIndex: cubit.selectedIndex,
      onDestinationSelected: (index) {
        cubit.changeScreen(index);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Iconsax.task), label: 'Tasks'),
        NavigationDestination(icon: Icon(Iconsax.chart_success), label: 'Done'),
        NavigationDestination(icon: Icon(Iconsax.archive), label: 'Archived'),
      ],
    );
  }
}
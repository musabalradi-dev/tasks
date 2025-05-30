import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_cubit.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_state.dart';
import 'package:tasks/features/layout/presentation/widget/bottom_navigation_bar_menu.dart';
import 'package:tasks/features/layout/presentation/widget/bottom_sheet.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) => Scaffold(
          key: cubit.scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.selectedIndex]),
          ),
          body: cubit.screens[cubit.selectedIndex],
          bottomNavigationBar: BottomNavigationBarMenu(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.scaffoldKey.currentState?.showBottomSheet(
                (context) => MyBottomSheet(),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
    );
  }

}
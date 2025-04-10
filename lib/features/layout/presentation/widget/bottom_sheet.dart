import 'package:flutter/material.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_cubit.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: cubit.titleController,
            decoration: InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle add task action
              cubit.insertToDatabase(
                title: cubit.titleController.text,
                date: '2023-08-01',
                time: '10:00 AM',
                status: 'pending',
              );
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
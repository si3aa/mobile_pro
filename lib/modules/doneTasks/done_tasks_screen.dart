import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/cubit/cubit.dart';
import 'package:pro/cubit/states.dart';
import 'package:pro/widgets/shared.dart';

class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({super.key});
  static String routeName = 'done';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/cubit/cubit.dart';
import 'package:pro/cubit/states.dart';
import 'package:pro/widgets/shared.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});
  static String routeName = 'new';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}

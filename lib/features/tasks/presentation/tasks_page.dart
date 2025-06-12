import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widgets/loader.dart';
import '../../../common/presentation/widgets/snack_bar.dart';
import '../../../core/di/locator.dart';
import '../data/models/task.dart';
import '../domain/cubits/tasks_cubit.dart';

@RoutePage()
class TasksPage extends StatefulWidget implements AutoRouteWrapper {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<TasksCubit>(),
      child: this,
    );
  }
}

class _TasksPageState extends State<TasksPage> {
  final _taskFieldController = TextEditingController();
  TasksCubit get _cubit => context.read<TasksCubit>();

  @override
  void dispose() {
    _taskFieldController.dispose();
    super.dispose();
  }

  void _listener(BuildContext context, TasksState state) {
    if (state.status.isError) {
      AppSnackBar.showError(
        context,
        state.errorMessage ?? 'Something went wrong :(',
      );
    }
  }

  void _showModal() {
    showDialog(
      context: context,
      builder: (cxt) {
        return AlertDialog(
          content: TextField(
            controller: _taskFieldController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Task',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                child: const Text('Add'),
                onPressed: () {
                  _cubit.add(Task(title: _taskFieldController.text));
                  cxt.router.pop();
                  _taskFieldController.clear();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: _listener,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              const Tooltip(
                message: 'Long press for remove',
                triggerMode: TooltipTriggerMode.tap,
                child: Icon(Icons.info_outline),
              ),
            ],
          ),

          body: state.status.isLoading
              ? const Loader()
              : ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (_, index) {
                    final task = state.tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      leading: Icon(
                        task.isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      onTap: () {
                        _cubit.changeStatus(task);
                      },
                      onLongPress: () {
                        _cubit.delete(task);
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: _showModal,
          ),
        );
      },
    );
  }
}

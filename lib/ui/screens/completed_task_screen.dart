import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllCompletedNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _getCompletedTaskInProgress == false,
              replacement: const CircularProgressIndicator(),
              child: ListView.separated(
                  itemCount: _completedTaskList.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TaskCard(taskStatus: TaskStatus.completed,
                      taskModel: _completedTaskList[index], refreshList: _getAllCompletedNewTaskList,);

                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  )),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _getAllCompletedNewTaskList() async {
    _getCompletedTaskInProgress = true;
    _completedTaskList = [];
    setState(() {});

    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.completedTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel =
      TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList.cast<TaskModel>();
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getCompletedTaskInProgress = false;
    setState(() {});
  }

}

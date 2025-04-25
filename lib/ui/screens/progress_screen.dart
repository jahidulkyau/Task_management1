import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllProgressNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _getProgressTaskInProgress == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                itemCount: _progressTaskList.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskStatus: TaskStatus.progress,
                    taskModel: _progressTaskList[index], refreshList: _getAllProgressNewTaskList
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getAllProgressNewTaskList() async {
    _getProgressTaskInProgress = true;
    _progressTaskList = [];
    setState(() {});

    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.progressTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel =
      TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList.cast<TaskModel>();
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getProgressTaskInProgress = false;
    setState(() {});
  }
}

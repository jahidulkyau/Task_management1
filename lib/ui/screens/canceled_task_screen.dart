import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _getCanceledTaskInProgress = true;
  List<TaskModel> _canceledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllCanceledNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _getCanceledTaskInProgress == false,
              replacement: const CircularProgressIndicator(),
              child: ListView.separated(
                  itemCount: _canceledTaskList.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return  TaskCard(taskStatus: TaskStatus.cancel,
                      taskModel: _canceledTaskList[index], refreshList: _getAllCanceledNewTaskList);

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
  Future<void> _getAllCanceledNewTaskList() async {
    _getCanceledTaskInProgress = true;
    _canceledTaskList = []; // ✅ Corrected here
    setState(() {});

    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.canceledTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel =
      TaskListModel.fromJson(response.data ?? {});
      _canceledTaskList = taskListModel.taskList.cast<TaskModel>();
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getCanceledTaskInProgress = false;
    setState(() {});
  }

}

import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_list_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/models/task_status_count_list_model.dart';
import 'package:task_management/data/models/task_status_count_model.dart';
import 'package:task_management/data/service/network_client.dart';
import 'package:task_management/ui/screens/add_new_task_screen.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  bool _getNewTaskInProgress = false;
  List<TaskModel> _newTaskList = [];
  @override
  void initState() {
    _getAllTaskStatusCount();
    _getAllTaskNewTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
                visible: _getStatusCountInProgress==false,
                replacement: Padding(
                  padding: const EdgeInsets.all(16),
                  child: const CircularProgressIndicator(),
                ),
                child: _buildSummarySection()),
            Visibility(
              visible: _getNewTaskInProgress,
              replacement: SizedBox(
                  height: 300,
                  child: const CircularProgressIndicator()),
              child: ListView.separated(
                  itemCount: _newTaskList.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return  TaskCard(
                      taskStatus: TaskStatus.sNew,
                      taskModel: _newTaskList[index], refreshList: _getAllTaskNewTaskList,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
  }

  Widget _buildSummarySection() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _taskStatusCountList.length,
              itemBuilder: (context, index) {
                return SummaaryCard(
                    title: _taskStatusCountList[index].status,
                    count: _taskStatusCountList[index].count);
              }),
        ));
  }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});

      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getAllTaskNewTaskList() async {
    _getNewTaskInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.newTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel =
          TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList.cast<TaskModel>();

    } else {
      showSnackBarMessage(context, response.errorMessage, true);
      _getNewTaskInProgress = true;
    }

    _getNewTaskInProgress = true;
    setState(() {});

  }
}

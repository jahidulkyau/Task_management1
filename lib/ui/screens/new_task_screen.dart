import 'package:flutter/material.dart';
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

  bool _getStatusCountInProgress =false;
  List<TaskStatusCountModel> _taskStatusCountList=[];
  @override
  void initState() {
_getAllTaskStatusCount();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: ListView.separated(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const TaskCard(taskStatus: TaskStatus.sNew,);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));

  }

  Widget _buildSummarySection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            SummaaryCard(
              title: 'New',
              count: 12,
            ),
            SummaaryCard(
              title: 'Progress',
              count: 10,
            ),
            SummaaryCard(
              title: 'Completed',
              count: 9,
            ),
            SummaaryCard(
              title: 'Cancel',
              count: 5,
            ),
          ],
        ),
      ),
    );
  }
  Future<void>_getAllTaskStatusCount ()async{
    _getStatusCountInProgress =true;
    setState(() {});

    final NetworkResponse response =await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel =TaskStatusCountListModel.fromJson(response.data??{});

      _taskStatusCountList =taskStatusCountListModel.statusCountList;
    }
    else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getStatusCountInProgress =false;
    setState(() {});

  }
}

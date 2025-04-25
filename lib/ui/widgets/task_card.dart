import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/service/network_client.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

enum TaskStatus {
  sNew,
  progress,
  completed,
  cancel,
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.refreshList,
  });

  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress=false;
  String _formatDate(String isoDate) {
    try {
      DateTime date = DateTime.parse(isoDate);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(widget.taskModel.description),
            Text(
                "Date: ${_formatDate(widget.taskModel.createdDate)}"), // ✅ formatted here
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                const Spacer(),
                Visibility(
                  visible: _inProgress==false,
                  replacement: CircularProgressIndicator(),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: _showUpdateStatusDialog,
                          icon: const Icon(Icons.edit),
                          color: Colors.green),
                      IconButton(
                          onPressed:_deleteTask,
                          icon: const Icon(Icons.delete),
                          color: Colors.red),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
        break;
      case TaskStatus.progress:
        color = Colors.purple;
        break;
      case TaskStatus.completed:
        color = Colors.green;
        break;
      case TaskStatus.cancel:
        color = Colors.red;
        break;
    }
    return color;
  }

  void _showUpdateStatusDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: (){
                    _popDialog();
                    if(isSelected('New'))return;
                    _changeTaskStatus("New");
                  },
                  title: Text("New"),
                  trailing: isSelected('New') ? const Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: (){
                    _popDialog();
                    if(isSelected('Progress'))return;
                    _changeTaskStatus("Progress");
                  },
                  title: Text("Progress"),
                  trailing: isSelected('Progress') ? const Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: (){
                    _popDialog();
                    if(isSelected('Completed'))return;
                    _changeTaskStatus("Completed");
                  },
                  title: Text("Completed"),
                  trailing: isSelected('Completed') ? const Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: (){
                    _popDialog();
                    if(isSelected('Canceled'))return;
                    _changeTaskStatus("Canceled");
                  },
                  title: Text("Canceled"),
                  trailing: isSelected('Canceled') ? const Icon(Icons.done) : null,
                ),
              ],
            ),
          );
        });
  }

  void _popDialog(){
    Navigator.pop(context);
  }

  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus (String status)async{
    _inProgress=true;
    setState(() {});
    final NetworkResponse response =await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));

    _inProgress=false;
    if(response.isSuccess){
      widget.refreshList();

    }
    else{
      showSnackBarMessage(context, response.errorMessage,true);

    }
  }
  Future<void> _deleteTask ()async{
    _inProgress=true;
    setState(() {});
    final NetworkResponse response =await NetworkClient.getRequest(url: Urls.deleteTaskUrl(widget.taskModel.id));

    _inProgress=false;
    if(response.isSuccess){
      widget.refreshList();

    }
    else{
      showSnackBarMessage(context, response.errorMessage,true);

    }
  }

}

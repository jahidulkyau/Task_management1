import 'package:flutter/material.dart';

enum TaskStatus{

  sNew,
  progress,
  completed,
  cancel,
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.taskStatus,
  });

  final TaskStatus taskStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Title will be here",style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),),
            const Text("Description will be here",),
            const Text("12/05/25",),
            Row(
              children: [
                Chip(
                  label: Text(
                    "New",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                const Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit),color: Colors.green,),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete),color: Colors.red,),

              ],
            )
          ],
        ),
      ),
    );
  }
  Color _getStatusChipColor(){

    late Color color;
    switch(taskStatus) {
      case TaskStatus.sNew:
        color =Colors.blue;

      case TaskStatus.progress:
        color =Colors.purple;

      case TaskStatus.completed:
        color=Colors.green;
      case TaskStatus.cancel:
       color=Colors.red;
    }
    return color;


  }
}

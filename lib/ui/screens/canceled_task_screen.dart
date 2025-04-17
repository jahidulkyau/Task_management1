import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const TaskCard(taskStatus: TaskStatus.cancel,);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                )),
          ),
        ],
      ),
    );
  }

}

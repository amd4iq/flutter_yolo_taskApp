import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class ToDoTile extends GetView<HomeController> {
  final String taskName;
  const ToDoTile({required this.taskName, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 10, right: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.deepPurple[400],
        ),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            openThreshold: 0.1,
            closeThreshold: 0.1,
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                onPressed: (context) {
                  controller.edit(controller.todos.indexOf(taskName));
                },
                backgroundColor: const Color.fromARGB(255, 69, 37, 123),
                foregroundColor: Colors.white,
                icon: Icons.edit_document,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.40,
            openThreshold: 0.1,
            closeThreshold: 0.1,
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                onPressed: (context) {
                  controller.addToHistory(controller.todos.indexOf(taskName));
                  Get.snackbar(
                    snackPosition: SnackPosition.BOTTOM,
                    'Task Deleted',
                    '',
                  );
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                onPressed: (context) {
                  Get.snackbar(
                    snackPosition: SnackPosition.BOTTOM,
                    controller.pinTask(controller.todos.indexOf(taskName)),
                    controller.todos[0].toString(),
                  );
                  controller.pin(controller.todos.indexOf(taskName));
                },
                backgroundColor: const Color.fromARGB(255, 26, 26, 133),
                foregroundColor: Colors.white,
                icon: Icons.arrow_circle_up,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.deepPurple[400],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: Get.height * 0.07,
            width: Get.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

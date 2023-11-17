import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class DeletedToDoTile extends GetView<HomeController> {
  final String deletedTaskName;
  const DeletedToDoTile({required this.deletedTaskName, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 10, right: 10, top: 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 175, 85, 85),
        ),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.30,
            openThreshold: 0.1,
            closeThreshold: 0.1,
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                onPressed: (context) {
                  controller
                      .undo(controller.deletedTodos.indexOf(deletedTaskName));
                },
                backgroundColor: const Color.fromARGB(255, 45, 181, 99),
                foregroundColor: Colors.white,
                icon: Icons.restore_from_trash,
                label: 'Restore',
              ),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 175, 85, 85),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: Get.height * 0.07,
            width: Get.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  deletedTaskName,
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

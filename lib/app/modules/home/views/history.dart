import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yolo_todo/app/config/my_behavior.dart';
import 'package:yolo_todo/app/modules/home/views/deleted_todo_tile.dart';
import 'package:yolo_todo/app/modules/home/views/home_view.dart';

import '../controllers/home_controller.dart';

class HistoryView extends GetView<HomeController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 30, bottom: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  backgroundColor: Colors.deepPurple,
                  icon: Icon(Icons.warning, color: Colors.red[200]),
                  title: const Text('Delete All History?'),
                  elevation: 5,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  content: const Text(
                      'Are you sure you want to delete all history?'),
                  contentTextStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 19,
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple[800],
                      ),
                      onPressed: () {
                        controller.deleteAllHistory();
                        Get.to(() => const HomeView(),
                            transition: Transition.noTransition);
                        Get.snackbar(
                          snackPosition: SnackPosition.BOTTOM,
                          'History Deleted',
                          '',
                        );
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete_forever, color: Colors.red[200]),
          ),
        ],
        backgroundColor: Colors.deepPurple,
        title: Text('Deleted Tasks',
            style: TextStyle(
              color: Colors.deepPurple[200],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Obx(
        () => Theme(
          data: ThemeData(
            canvasColor: Colors.transparent,
            // make the elevation 0
            shadowColor: const Color.fromARGB(93, 0, 0, 0),

            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ReorderableListView(
                children: [
                  for (final todo in controller.deletedTodos)
                    DeletedToDoTile(
                      key: ValueKey(todo),
                      deletedTaskName: todo as String,
                    ),
                ],
                onReorder: (int oldIndex, int newIndex) {
                  controller.reorderDeleted(oldIndex, newIndex);
                }),
          ),
        ),
      ),
    );
  }
}

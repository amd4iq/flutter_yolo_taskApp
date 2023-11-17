import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:yolo_todo/app/config/my_behavior.dart';
import 'package:yolo_todo/app/modules/home/views/history.dart';
import 'package:yolo_todo/app/modules/home/views/todo_tile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        leading: Obx(
          () => Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.deepPurple[400]!,
                  width: 2,
                ),
              ),
              child: Text(
                controller.todos.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const HistoryView());
            },
            icon: Icon(Icons.history, color: Colors.deepPurple[200]),
          ),
        ],
        backgroundColor: Colors.deepPurple,
        title: Text('Pull down to add a task',
            style: TextStyle(
              color: Colors.deepPurple[200],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 100,
        animSpeedFactor: 1,
        height: 100,
        backgroundColor: Colors.deepPurple[200],
        color: Colors.deepPurple,
        onRefresh: () {
          return controller.onRefresh();
        },
        child: Obx(
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
                    for (final todo in controller.todos)
                      ToDoTile(
                        key: ValueKey(todo),
                        taskName: todo as String,
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    controller.reorder(oldIndex, newIndex);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

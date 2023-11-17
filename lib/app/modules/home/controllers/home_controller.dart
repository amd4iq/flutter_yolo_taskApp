import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yolo_todo/app/modules/home/views/add_todo.dart';
import 'package:yolo_todo/app/modules/home/views/edit.todo.dart';

class HomeController extends GetxController {
  // instance of todos list
  final List todos = <dynamic>[].obs;

  // list of deleted todos
  final deletedTodos = <dynamic>[].obs;

  // text editing controller
  final TextEditingController addToDOController = TextEditingController();

  // instance of get storage
  final box = GetStorage();

  // --------------------------------

  // add todo and but the new todo at the top of the list
  void add() {
    if (addToDOController.text.isNotEmpty) {
      todos.insert(0, addToDOController.text);
      box.write('todos', todos);
      addToDOController.clear();
    }
  }

  // --------------------------------

  // delete todo function
  void addToHistory(int index) {
    deletedTodos.insert(0, todos[index]);
    todos.removeAt(index);
    box.write('deleted-items', deletedTodos);
  }

  // --------------------------------

  // add function to edit the clicked todo
  void edit(int index) {
    Get.to(() => EditToDoView(index: index),
        transition: Transition.noTransition);
  }

  // save Edited Todo
  void saveEditedTodo(int index) {
    todos[index] = addToDOController.text;
    box.write('todos', todos);
    addToDOController.clear();
  }

  // --------------------------------

  // check if the feild is empty for the editing page
  checkIfTheFeildIsEmptyInTheEditView(int index) {
    if (addToDOController.text.isNotEmpty) {
      saveEditedTodo(todos.indexOf(todos[index]));
      Get.back();
    } else {
      Get.snackbar(
        'Empty Task',
        'Please enter a task',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // undo function
  void undo(int index) {
    todos.add(deletedTodos[index]);
    deletedTodos.removeAt(index);
    box.write('deleted-items', deletedTodos);
    box.write('todos', todos);
  }

  // --------------------------------

  // delete all history function
  void deleteAllHistory() {
    deletedTodos.clear();
    box.write('deleted-items', deletedTodos);
  }

  // --------------------------------

  // delete all function
  void deleteAll() {
    deletedTodos.addAll(todos);
    todos.clear();
    box.write('deleted-items', todos);
  }

  // --------------------------------

  // restore all function
  void restoreAll() {
    todos.addAll(deletedTodos);
    deletedTodos.clear();
    box.write('todos', todos);
  }

  // --------------------------------

  // delete all Permanently function
  void deleteAllPermanently() {
    deletedTodos.clear();
    box.write('deleted-items', deletedTodos);
  }

  // --------------------------------

  // pin fav todo to the top of the list
  void pin(int index) {
    todos.insert(0, todos[index]);
    todos.removeAt(index + 1);
    box.write('todos', todos);
  }

  // --------------------------------

  // reorder using ReorderableListView
  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final dynamic item = todos.removeAt(oldIndex);
    todos.insert(newIndex, item);
    box.write('todos', todos);
    box.read('todos');
  }

  //! todo valuekey for ReorderableListView for todos
  ValueKey<dynamic> valueKey(String index) {
    return ValueKey<dynamic>(index);
  }
  // --------------------------------

  // reorder deleted todo using ReorderableListView
  void reorderDeleted(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final dynamic item = deletedTodos.removeAt(oldIndex);
    deletedTodos.insert(newIndex, item);
    box.write('deleted-items', deletedTodos);
    box.read('deleted-items');
  }

  //! todo valuekey for ReorderableListView for deleted items
  ValueKey<dynamic> deletedValueKey(String index) {
    return ValueKey<dynamic>(index);
  }
  // --------------------------------

  // on refresh function for liquid pull to refresh widget
  Future<void> onRefresh() {
    return Future<void>.delayed(const Duration(seconds: 1), () {
      showGeneralDialog(
          transitionDuration: const Duration(milliseconds: 0),
          context: Get.context!,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const AddToDoView();
          });
    });
  }

  // --------------------------------

  // move Task  to top of the list and check if the task is already at the top
  String pinTask(int index) {
    if (index == 0) {
      return 'Task already at the top';
    } else {
      pin(index);
      return 'Task moved to top of the list';
    }
  }

  // --------------------------------

  // on init function
  @override
  void onInit() {
    super.onInit();
    if (box.read('deleted-items') != null) {
      deletedTodos.addAll(box.read('deleted-items'));
    }
    if (box.read('todos') != null) {
      todos.addAll(box.read('todos'));
    }
  }
  // --------------------------------

  // dispose
  @override
  void dispose() {
    addToDOController.dispose();

    super.dispose();
  }

  // --------------------------------
}

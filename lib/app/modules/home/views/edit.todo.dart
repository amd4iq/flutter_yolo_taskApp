// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yolo_todo/app/modules/home/views/home_view.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class EditToDoView extends GetView<HomeController> {
  final int index;
  const EditToDoView({required this.index, super.key});
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              autofocus: true,
              controller: controller.addToDOController,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.deepPurple,
              cursorWidth: 6,
              maxLines: 3,
              decoration: InputDecoration(
                helperText: controller.todos[index].toString(),
                helperStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(92, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              style: TextStyle(
                fontSize: 34,
                color: Colors.deepPurple[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const HomeView(),
                          transition: Transition.noTransition);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 60,
                      width: Get.width * 0.3,
                      child: const Center(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.checkIfTheFeildIsEmptyInTheEditView(index);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 60,
                      width: Get.width * 0.6,
                      child: const Center(
                        child: Text('Edit Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.05)
          ],
        )),
      ),
    );
  }
}

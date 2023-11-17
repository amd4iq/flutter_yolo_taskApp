// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class AddToDoView extends GetView<HomeController> {
  const AddToDoView({
    super.key,
  });
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
              decoration: const InputDecoration(
                hintText: 'What do you want to do?',
                hintStyle: TextStyle(
                  fontSize: 34,
                  color: Color.fromARGB(92, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              style: TextStyle(
                fontSize: 34,
                color: Colors.deepPurple[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                controller.add();
                Get.back();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 60,
                width: Get.width * 0.9,
                child: const Center(
                  child: Text('Add ToDo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05)
          ],
        )),
      ),
    );
  }
}

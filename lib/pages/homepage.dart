import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../todo_controller.dart';

class HomePage extends GetView<TodoController> {
  HomePage({Key? key}) : super(key: key);

  final formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(TodoController()).getTodo();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CRUD FIREBASE",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKeyLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.title,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) => value.toString().isEmpty
                          ? 'content tidak boleh kosong'
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKeyLogin.currentState!.validate()) {
                        controller.addTodo();
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("ALL NOTES"),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => controller.loading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
                          children: controller.todoList
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      onTap: () {},
                                      title: Text(e.title!),
                                      trailing: SizedBox(
                                          width: 100,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      controller
                                                          .deleteTodo(e.id!);
                                                    },
                                                    child: Icon(Icons.delete)),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    controller.updatedTitle
                                                        .text = e.title!;
                                                    Get.defaultDialog(
                                                      title: "UPDATE TODO",
                                                      content: StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                          return Container(
                                                            height: 100,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        controller
                                                                            .updatedTitle,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .updateTodo(
                                                                            e);
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 45,
                                                                    width: 45,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(Icons.edit),
                                                )
                                              ])),
                                    ),
                                  ))
                              .toSet()
                              .toList(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

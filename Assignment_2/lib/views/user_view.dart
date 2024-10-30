// lib/views/user_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserView extends StatelessWidget {
  final UserController _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("GetX & MVVM Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Enter name"),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _controller.insertUser(value, 25);
                  nameController.clear();
                }
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              return _controller.users.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _controller.users.length,
                        itemBuilder: (context, index) {
                          final user = _controller.users[index];
                          return ListTile(
                            title: Text('Name: ${user.name}'),
                            subtitle: Text('Age: ${user.age}'),
                          );
                        },
                      ),
                    )
                  : const Text("No users found.");
            }),
          ],
        ),
      ),
    );
  }
}

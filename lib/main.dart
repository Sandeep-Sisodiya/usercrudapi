import 'package:flutter/material.dart';
import 'package:usercrudapi/Models/user.dart';
import 'package:usercrudapi/user_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
}
  
class _MyHomePageState
    extends State<MyHomePage> {

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final user =
      await UserServices.fetchUsers();

      setState(() {
        users = user;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User CRUD Operations',
        ),
      ),

      body: ListView.builder(
        itemCount: users.length,

        itemBuilder: (context, index) {

          return Card(
            margin: const EdgeInsets.all(8),

            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),

              title: Text(
                users[index].name,
              ),

              subtitle: Text(
                "Age : ${users[index].age}\nRole : ${users[index].role}",
              ),

              trailing: SizedBox(
                width: 100,

                child: Row(
                  children: [

                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                UpdateUser(
                                  user:
                                  users[index],
                                  fetchUsers:
                                  fetchUsers,
                                ),
                          ),
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DeleteUser(
                                  id: users[index]
                                      .id,
                                  fetchUsers:
                                  fetchUsers,
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton:
      FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddUser(
                fetchUsers: fetchUsers,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddUser extends StatelessWidget {

  final Function fetchUsers;

  AddUser({
    super.key,
    required this.fetchUsers,
  });

  final TextEditingController
  nameController =
  TextEditingController();

  final TextEditingController
  ageController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add User",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
              nameController,
              decoration:
              const InputDecoration(
                labelText: "Name",
              ),
            ),

            TextField(
              controller:
              ageController,
              keyboardType:
              TextInputType.number,
              decoration:
              const InputDecoration(
                labelText: "Age",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () async {

                await UserServices
                    .addUser(
                  nameController.text,
                  int.tryParse(
                      ageController
                          .text) ??
                      0,
                );

                fetchUsers();

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                "Add User",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateUser extends StatelessWidget {

  final User user;
  final Function fetchUsers;

  UpdateUser({
    super.key,
    required this.user,
    required this.fetchUsers,
  });

  @override
  Widget build(BuildContext context) {

    final nameController =
    TextEditingController(
      text: user.name,
    );

    final ageController =
    TextEditingController(
      text: user.age.toString(),
    );

    final roleController =
    TextEditingController(
      text: user.role,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update User",
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
              nameController,
              decoration:
              const InputDecoration(
                labelText: "Name",
              ),
            ),

            TextField(
              controller:
              ageController,
              keyboardType:
              TextInputType.number,
              decoration:
              const InputDecoration(
                labelText: "Age",
              ),
            ),

            TextField(
              controller:
              roleController,
              decoration:
              const InputDecoration(
                labelText: "Role",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () async {

                await UserServices
                    .updateUser(
                  user.id,
                  nameController.text,
                  int.tryParse(
                      ageController
                          .text) ??
                      0,
                  roleController.text,
                );

                fetchUsers();

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                "Update User",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteUser extends StatelessWidget {

  final String id;
  final Function fetchUsers;

  const DeleteUser({
    super.key,
    required this.id,
    required this.fetchUsers,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delete User",
        ),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () async {

            await UserServices
                .deleteUser(id);

            fetchUsers();

            Navigator.pop(
              context,
            );
          },

          child: const Text(
            "Confirm Delete",
          ),
        ),
      ),
    );
  }
}
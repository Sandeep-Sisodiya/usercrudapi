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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final user = await UserServices.fetchUsers();
    setState(() {
      users = user;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User CRUD Operations with APIs')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(users[index].name),
            subtitle: Text("${users[index].age}"),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
class addUser extends StatelessWidget {
  final Function fetchUsers;
  addUser({required this.fetchUsers});

  @override
  final TextEditingController nameCount = TextEditingController();
  final TextEditingController age = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameCount,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: age,
            decoration: InputDecoration(
              labelText: 'Age',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameCount.text;
              final age = int.parse(this.age.text);
              await UserServices.addUser(name, age);
              fetchUsers();
            },
            child: Text('Add User'),
          ),
        ],
      ),
    );

  }
}


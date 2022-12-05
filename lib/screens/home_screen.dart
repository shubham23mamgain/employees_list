import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zylu_test/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<UserM> users = allUsers;

  Stream<List<UserM>> readEmployees() =>
      FirebaseFirestore.instance.collection("employees").snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => UserM.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Employees List"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<UserM>>(
        stream: readEmployees(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong ! ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  child: Card(
                    color: user.isActive && user.timeInCompany! >= 5
                        ? Colors.green
                        : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: buildUserListTile(
                      user,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget buildUserListTile(UserM user) {
  return ListTile(
    contentPadding: const EdgeInsets.all(16),
    title: Text(user.name!),
    subtitle: Text("${user.timeInCompany} years"),
    trailing: user.isActive ? const Text("Active") : const Text("Not Active"),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(user.image!),
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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

            return SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Slidable(
                        key: Key(user.name!),
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            _showSnackBar(context, '${user.name} is shared',
                                Colors.green);
                            setState(() => users.removeAt(index));
                          }),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                _showSnackBar(context, '${user.name} is shared',
                                    Colors.green);
                                setState(() => users.removeAt(index));
                              },
                              backgroundColor: Colors.green,
                              icon: Icons.share,
                              label: "Share",
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                _showSnackBar(context,
                                    '${user.name} is archived', Colors.blue);
                                setState(() => users.removeAt(index));
                              },
                              backgroundColor: Colors.blue,
                              icon: Icons.archive,
                              label: "Archive",
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            _showSnackBar(
                                context, '${user.name} is deleted', Colors.red);
                            setState(() => users.removeAt(index));
                          }),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                _showSnackBar(context,
                                    '${user.name} is deleted', Colors.red);
                                setState(() => users.removeAt(index));
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: "Delete",
                            ),
                          ],
                        ),
                        child: buildUserListTile(
                          user,
                        ),
                      ),
                    ),
                  );
                },
              ),
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
  return Builder(builder: (context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Text(user.name!),
      subtitle: Text("${user.timeInCompany} years"),
      trailing: user.isActive ? const Text("Active") : const Text("Not Active"),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(user.image!),
      ),
      onTap: () {
        final slidable = Slidable.of(context)!;
        final isClosed = slidable.actionPaneType.value == ActionPaneType.none;

        if (isClosed) {
          slidable.openStartActionPane();
        } else {
          slidable.close();
        }
      },
    );
  });
}

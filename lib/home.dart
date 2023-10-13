// import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_donation/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void deletedonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        title: Center(
            child: const Text(
          " blood donation",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        )),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 248, 248)),
        backgroundColor: Color.fromARGB(255, 131, 0, 0),
      ),
      backgroundColor: Color.fromARGB(255, 215, 237, 255),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 255, 149, 141),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: donor.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot donorsnap = snapshot.data!.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 199, 195, 195),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 236, 236, 236),
                                blurRadius: 15,
                                spreadRadius: 10)
                          ]),
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color.fromARGB(255, 244, 118, 118),
                            child: Text(donorsnap['group']),
                          ),
                          title: Text(donorsnap['name']),
                          subtitle: Text(donorsnap['phone'].toString()),
                          trailing: IconButton(
                            color: Colors.red,
                            onPressed: () {
                              deletedonor(donorsnap.id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

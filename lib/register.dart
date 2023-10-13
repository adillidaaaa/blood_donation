import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<String> bloodGroup = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  String? selectedGroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup,
    };
    donor.add(data);
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
          "donor",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        )),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 248, 248)),
        backgroundColor: Color.fromARGB(255, 131, 0, 0),
      ),
      backgroundColor: Color.fromARGB(255, 215, 237, 255),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: InputDecoration(
                  labelText: "Donor Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select Blood Group",
                  border: OutlineInputBorder(),
                ),
                items: bloodGroup
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGroup = value;
                  });
                },
                value: selectedGroup,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  addDonor();
                  Navigator.pop(context);
                },
                child: Text("Submit"),
                color: Color.fromARGB(255, 212, 146, 141),
                minWidth: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

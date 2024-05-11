import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import './admin.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLoginPage> {
  final TextEditingController adminIdController = TextEditingController();
  final TextEditingController adminPasswordController = TextEditingController();
  final DatabaseReference adminRef =
      FirebaseDatabase.instance.ref().child('admins');
  void _handleAdminLogin() async {
    String adminId = adminIdController.text.trim();
    String adminPassword = adminPasswordController.text.trim();
    if (adminId.isEmpty || adminPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Admin ID and admin password are required.')),
      );
      return;
    }
    try {
      DatabaseEvent event =
          await adminRef.orderByChild('adminId').equalTo(adminId).once();
      if (event.snapshot.exists) {
        DataSnapshot snapshot = event.snapshot.children.first;
        String databasePassword =
            snapshot.child('adminPassword').value.toString();

        if (databasePassword == adminPassword) {
          // Admin ID and password match, navigate to another page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Incorrect admin password. Please try again.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'AdminID does not exist. Please sign up as an admin and prove your identity.')),
        );
      }
    } catch (error) {
      // Handle any errors during the query
      print("Error querying database: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error querying database: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Admin Login'),
        centerTitle: true,
        surfaceTintColor: Color.fromARGB(235, 0, 236, 248),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: adminIdController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: 'Admin ID'),
          ),
          TextFormField(
            controller: adminPasswordController,
            decoration: InputDecoration(labelText: 'Admin Password'),
            obscureText: true,
          ),
          ElevatedButton(onPressed: _handleAdminLogin, child: Text('Login'))
        ],
      ),
    );
  }
}

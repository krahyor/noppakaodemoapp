// page_c.dart - Tab C ของ Mini App 1
import 'package:flutter/material.dart';
import 'package:noppakao/app.dart';
import 'package:noppakao/mini_apps/app1/app1_shell.dart';
import 'package:noppakao/mini_apps/app1/models/accounts.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();

  Role _role = Role.user;
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Account")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstname = value!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastname = value!; // Save the last name
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    if (!value.contains('@')) {
                      return 'รูปแบบอีเมลไม่ถูกต้อง';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: _role,
                  decoration: InputDecoration(
                    labelText: 'ดำแหน่ง',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      Role.values.map((key) {
                        return DropdownMenuItem(
                          value: key,
                          child: Text(key.title),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _role = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      accounts.add(
                        Accounts(
                          firstName: _firstname,
                          email: _email,
                          lastName: _lastname,
                          password: _password,
                          role: _role,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootApp(),
                        ),
                      );
                    }
                  },
                  child: Text('Add Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

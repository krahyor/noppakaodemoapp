import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noppakao/app.dart';

class FormScore extends StatefulWidget {
  const FormScore({super.key});

  @override
  State<FormScore> createState() => _FormScoreState();
}

class _FormScoreState extends State<FormScore> {
  final CollectionReference _studentCollection = FirebaseFirestore.instance
      .collection("students");
  final _formKey = GlobalKey<FormState>();
  int _score = 0;
  String _studentId = '';
  String _email = '';
  String _firstName = '';
  String _lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Score')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอก Student ID';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _studentId = value!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "อีเมล",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกอีเมล';
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
                    labelText: 'ชื่อ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'นามสกุล',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกนามสกุล';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'คะแนน (1-100)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกคะแนน';
                    }
                    final score = int.tryParse(value);
                    if (score == null) {
                      return 'กรุณากรอกตัวเลขเท่านั้น';
                    }
                    if (score < 1 || score > 100) {
                      return 'คะแนนต้องอยู่ระหว่าง 1-100';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _score = int.parse(value!);
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Here you can handle the saved data
                      await _studentCollection.add({
                        'first_name': _firstName,
                        'last_name': _lastName,
                        'email': _email,
                        'student_id': _studentId,
                        'score': _score,
                      });
                      _formKey.currentState!.reset();

                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootApp(),
                        ),
                      );
                    }
                    // Handle form submission
                  },
                  child: Text('บันทึก'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

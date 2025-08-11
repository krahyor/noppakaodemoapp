// page_y.dart - Tab Y ของ Mini App 2
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noppakao/mini_apps/app2/pages/form_scores.dart';

class Score extends StatefulWidget {
  const Score({super.key});

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Score")),
      body: Column(
        children: [
          // ปุ่มเพิ่มอยู่ด้านบน
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Student'),
                onPressed: () async {
                  final changed = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FormScore()),
                  );
                  if (changed == true && mounted) {
                    // Firestore snapshot จะอัปเดตเอง ไม่ต้อง setState
                  }
                },
              ),
            ),
          ),
          // List แสดงข้อมูล (ต้องห่อ Expanded เพื่อให้ได้พื้นที่)
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('students').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text('ยังไม่มีข้อมูลนักศึกษา'));
                }
                return ListView(
                  children:
                      docs.map((doc) {
                        final score = (doc['score'] ?? 0) as int;
                        final color =
                            score >= 80
                                ? Colors.green
                                : score >= 50
                                ? Colors.yellow
                                : Colors.red;
                        return Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: color,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(
                                  doc['score'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Student ID: ${doc['student_id']}'),
                                    Text(
                                      'Name: ${doc['first_name']} ${doc['last_name']}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Email: ${doc['email']}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Score: $score',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

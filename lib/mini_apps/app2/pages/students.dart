// page_x.dart - Tab X ของ Mini App 2
import 'package:flutter/material.dart';
import 'package:noppakao/mini_apps/app2/models/students.dart';

class Students extends StatelessWidget {
  const Students({super.key});

  Color scoreColor(score) {
    if (score >= 80) {
      return Colors.green;
    } else if (score >= 50) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: scoreColor(data[index].score),
                  ),
                  child: Column(
                    children: [
                      Text('student id : ${data[index].studentId}'),
                      Text(
                        'student name : ${data[index].firstName} ${data[index].lastName}',
                      ),
                      Text('student score : ${data[index].score}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

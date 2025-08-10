// page_a.dart - Tab A ของ Mini App 1
import 'package:flutter/material.dart';
import 'package:noppakao/mini_apps/app1/models/accounts.dart';
import 'package:noppakao/mini_apps/app1/pages/add_account.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddAccount page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAccount()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(title: const Text('Mini App 1 - Account')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.all(10),

                  child: Row(
                    children: [
                      Image.asset(
                        'assets/app1/images/pic1.png',
                        width: 50,
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${accounts[index].firstName} ${accounts[index].lastName}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Email: ${accounts[index].email}'),
                          Text('Role: ${accounts[index].role.title}'),
                        ],
                      ),
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

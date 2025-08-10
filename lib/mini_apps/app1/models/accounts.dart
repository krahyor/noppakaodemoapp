enum Role {
  user(title: "ผู้ใช้งาน"),
  admin(title: "ผู้ดูแลระบบ");

  const Role({required this.title});

  final String title;
}

class Accounts {
  Accounts({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.password,
    required this.role,
  });

  String firstName;
  String lastName;
  String email;
  String password;
  Role role;
}

List<Accounts> accounts = [
  Accounts(
    firstName: "John",
    email: "john@example.com",
    lastName: "Doe",
    password: "password123",
    role: Role.admin,
  ),
  Accounts(
    firstName: "Jane",
    email: "jane@example.com",
    lastName: "Smith",
    password: "password456",
    role: Role.user,
  ),
  Accounts(
    firstName: "Alice",
    email: "alice@example.com",
    lastName: "Johnson",
    password: "password789",
    role: Role.user,
  ),
  Accounts(
    firstName: "Bob",
    email: "bob@example.com",
    lastName: "Brown",
    password: "password101",
    role: Role.user,
  ),
];

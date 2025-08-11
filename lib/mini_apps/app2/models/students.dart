class Student {
  String studentId;
  String email;
  String firstName;
  String lastName;
  int score;

  Student({
    required this.studentId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.score,
  });
}

List<Student> data = [
  Student(
    studentId: 'S001',
    email: "admin@example.com",
    firstName: 'John',
    lastName: 'Doe',
    score: 30,
  ),
  Student(
    studentId: 'S002',
    email: "jane@example.com",
    firstName: 'Jane',
    lastName: 'Smith',
    score: 55,
  ),
  Student(
    studentId: 'S003',
    email: "alice@example.com",
    firstName: 'Alice',
    lastName: 'Johnson',
    score: 78,
  ),
  Student(
    studentId: 'S004',
    email: "bob@example.com",
    firstName: 'Bob',
    lastName: 'Brown',
    score: 88,
  ),
  Student(
    studentId: 'S005',
    email: "charlie@example.com",
    firstName: 'Charlie',
    lastName: 'Davis',
    score: 95,
  ),
];

class Subject {
  String name;
  int credit;
  List<DateTime> time;
  Subject({required this.name, required this.credit, required this.time});
}

List<Subject> subjects = [
  Subject(
    name: 'Mathematics',
    credit: 3,
    time: [DateTime(2023, 9, 1, 9, 0), DateTime(2023, 9, 3, 9, 0)],
  ),
  Subject(
    name: 'Science',
    credit: 4,
    time: [DateTime(2023, 9, 2, 10, 0), DateTime(2023, 9, 4, 10, 0)],
  ),
  Subject(
    name: 'History',
    credit: 2,
    time: [DateTime(2023, 9, 1, 11, 0), DateTime(2023, 9, 3, 11, 0)],
  ),
];

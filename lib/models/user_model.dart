class UserModel{
  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

  UserModel(
  {required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory UserModel.fromJson(jsonData)
  {
    return UserModel(
        id: jsonData['id'],
        name: jsonData['name'],
        email: jsonData['email'],
        gender: jsonData['gender'],
        status: jsonData['status'],
    );
  }
}

class UserModel {
  String phone;
  String? firstName;
  String? lastName;
  UserModel({
    required this.phone,
    this.firstName,
    this.lastName
  });
}
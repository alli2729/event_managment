class RegisterUserDto {
  String firstName;
  String lastName;
  String gender;
  String username;
  String password;

  RegisterUserDto({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstName,
      "lastname": lastName,
      "gender": gender,
      "username": username,
      "password": password,
    };
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? password;
  String? username;
  String? deviceToken;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.password,
      this.username,
      this.deviceToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['username'] = this.username;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}

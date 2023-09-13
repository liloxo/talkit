class UserModel {
  int? id;
  String? username;
  String? email;
  String? password;
  int? verifycode;
  int? approve;
  String? timecreate;
  String? image;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.verifycode,
      this.approve,
      this.timecreate,
      this.image});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    verifycode = json['verifycode'];
    approve = json['approve'];
    timecreate = json['timecreate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['verifycode'] = verifycode;
    data['approve'] = approve;
    data['timecreate'] = timecreate;
    data['image'] = image;
    return data;
  }
}
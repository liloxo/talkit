class FriendsListModel {
  int? useroneId;
  String? useroneUsername;
  String? useroneEmail;
  String? useroneImage;
  int? friendsId;

  FriendsListModel(
      {this.useroneId,
      this.useroneUsername,
      this.useroneEmail,
      this.useroneImage,
      this.friendsId});

  FriendsListModel.fromJson(Map<dynamic, dynamic> json) {
    useroneId = json['userone_id'];
    useroneUsername = json['userone_username'];
    useroneEmail = json['userone_email'];
    useroneImage = json['userone_image'];
    friendsId = json['friends_id'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data =  <dynamic, dynamic>{};
    data['userone_id'] = useroneId;
    data['userone_username'] = useroneUsername;
    data['userone_email'] = useroneEmail;
    data['userone_image'] = useroneImage;
    data['friends_id'] = friendsId;
    return data;
  }
}
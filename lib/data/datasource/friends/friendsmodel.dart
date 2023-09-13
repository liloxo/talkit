class FriendModel {
  int? otherUserId;
  String? otherUsername;
  String? otherImage;
  int? friendsId;

  FriendModel(
    {this.otherUserId, this.otherUsername, this.otherImage, this.friendsId});

  FriendModel.fromJson(Map<String, dynamic> json) {
    otherUserId = json['other_user_id'];
    otherUsername = json['other_username'];
    otherImage = json['other_image'];
    friendsId = json['friends_id'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['other_user_id'] = otherUserId;
    data['other_username'] = otherUsername;
    data['other_image'] = otherImage;
    data['friends_id'] = friendsId;
    return data;
  }
}
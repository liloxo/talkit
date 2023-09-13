class SearchModel {
  int? id;
  String? username;
  String? image;
  String? friendshipStatus;

  SearchModel({this.id, this.username, this.image, this.friendshipStatus});

  SearchModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    username = json['username'];
    image = json['image'];
    friendshipStatus = json['friendship_status'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['image'] = image;
    data['friendship_status'] = friendshipStatus;
    return data;
  }
}
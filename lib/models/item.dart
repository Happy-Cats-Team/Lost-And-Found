class Item {
  String? title;
  String? description;
  String? type;
  String? phone;
  String? telegram;
  String? where;
  String? uid;

  Item(
      {this.title,
      this.description,
      this.type,
      this.phone,
      this.telegram,
      this.where,
      this.uid});

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    type = json['type'];
    phone = json['phone'];
    telegram = json['telegram'];
    where = json['where'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['telegram'] = this.telegram;
    data['where'] = this.where;
    data['uid'] = this.uid;
    return data;
  }
}

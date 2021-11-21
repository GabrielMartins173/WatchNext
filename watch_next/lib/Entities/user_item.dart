class UserItem {
  final int userId;
  final int itemId;

  UserItem(this.userId, this.itemId);

  UserItem.fromJson(Map<dynamic, dynamic> json)
      : userId = json['USER_ID'],
        itemId = json['ITEM_ID'];
}
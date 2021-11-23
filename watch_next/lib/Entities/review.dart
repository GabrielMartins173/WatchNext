class Review {
  final int userId;
  final int itemId;
  final String review;

  Review(this.userId, this.itemId, this.review);

  Review.fromJson(Map<dynamic, dynamic> json)
      : userId = json['USER_ID'],
        itemId = json['ITEM_ID'],
        review = json['TEXT'];
}
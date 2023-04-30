
import '../ultilities/Constant.dart';

class Categories {
  final int? id;
  final String? name;
  final int? userId;
  final String? createdDate;

  Categories({this.id, this.name, this.userId, this.createdDate});

  Map<String, dynamic> toMap(){
    return {
      Constant.KEY_CATEGORY_ID : id,
      Constant.KEY_CATEGORY_NAME : name,
      Constant.KEY_CATEGORY_USER_ID : userId,
      Constant.KEY_CATEGORY_CREATED_DATE: createdDate,
    };
  }

  static Categories fromMap(Map<String, dynamic> map) {
    return Categories(
      id: map[Constant.KEY_USER_ID],
      name: map[Constant.KEY_CATEGORY_NAME],
      userId: map[Constant.KEY_CATEGORY_USER_ID],
      createdDate: map[Constant.KEY_CATEGORY_CREATED_DATE].toString()
    );
  }
}
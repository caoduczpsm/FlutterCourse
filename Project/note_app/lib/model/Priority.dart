
import '../ultilities/Constant.dart';

class Priority {
  final int? id;
  final String? name;
  final int? userId;
  final String? createdDate;

  Priority({this.id, this.name, this.userId, this.createdDate});

  Map<String, dynamic> toMap(){
    return {
      Constant.KEY_PRIORITY_ID : id,
      Constant.KEY_PRIORITY_NAME : name,
      Constant.KEY_PRIORITY_USER_ID : userId,
      Constant.KEY_PRIORITY_CREATED_DATE: createdDate
    };
  }

  static Priority fromMap(Map<String, dynamic> map) {
    return Priority(
      id: map[Constant.KEY_PRIORITY_ID],
      name: map[Constant.KEY_PRIORITY_NAME],
      userId: map[Constant.KEY_CATEGORY_USER_ID],
      createdDate: map[Constant.KEY_PRIORITY_CREATED_DATE].toString()
    );
  }
}
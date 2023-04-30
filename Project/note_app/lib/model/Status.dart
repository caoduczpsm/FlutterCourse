
import '../ultilities/Constant.dart';

class Status {
  final int? id;
  final String? name;
  final int? userId;
  final String? createdDate;

  Status({this.id, this.name, this.userId, this.createdDate});

  Map<String, dynamic> toMap(){
    return {
      Constant.KEY_STATUS_ID : id,
      Constant.KEY_STATUS_NAME : name,
      Constant.KEY_STATUS_USER_ID : userId,
      Constant.KEY_STATUS_CREATED_DATE: createdDate
    };
  }

  static Status fromMap(Map<String, dynamic> map) {
    return Status(
      id: map[Constant.KEY_STATUS_ID],
      name: map[Constant.KEY_STATUS_NAME],
      userId: map[Constant.KEY_CATEGORY_USER_ID],
      createdDate: map[Constant.KEY_STATUS_CREATED_DATE].toString()
    );
  }
}
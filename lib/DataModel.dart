import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.status,
    this.message,
    this.userId,
    this.userCode,
    this.userName,
    this.userGroup,
    this.empId,
    this.userType,
    this.loginDetailsId,
  });

  var status;
  var message;
  var userId;
  var userCode;
  var userName;
  var userGroup;
  var empId;
  var userType;
  var loginDetailsId;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    status: json["Status"],
    message: json["Message"],
    userId: json["UserID"],
    userCode: json["UserCode"],
    userName: json["UserName"],
    userGroup: json["UserGroup"],
    empId: json["EmpID"],
    userType: json["UserType"],
    loginDetailsId: json["LoginDetailsID"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "UserID": userId,
    "UserCode": userCode,
    "UserName": userName,
    "UserGroup": userGroup,
    "EmpID": empId,
    "UserType": userType,
    "LoginDetailsID": loginDetailsId,
  };
}

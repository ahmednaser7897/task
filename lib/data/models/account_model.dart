
class AccountModel {
  int? status;
  Account? account;
  AccountModel({this.status, this.account});
  AccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['account'] != null) {
     account=Account.fromJson(json['account'][0]);
    }
  }

}

class Account {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? updatedAt;
  String? createdAt;

  Account(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.updatedAt,
      this.createdAt});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}


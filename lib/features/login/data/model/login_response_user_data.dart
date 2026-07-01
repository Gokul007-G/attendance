class LoginResponseUserData {
  String? id;
  String? name;
  String? designation;
  String? location;
  String? role;

  LoginResponseUserData({this.id, this.name, this.designation, this.role,this.location});

  LoginResponseUserData.fromJson(Map<String, dynamic> json) {
    id = json['emp_id']?.toString();
    name = json['emp_name'];
    designation = json['designation']?.toString();
    location = json['location']?.toString();
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['designation'] = designation;
    data['location'] = location;
    data['role'] = role;
    return data;
  }
}

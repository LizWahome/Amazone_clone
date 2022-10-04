class UserDetailsModel {
  late String name;
  late String address;

  UserDetailsModel({required this.name, required this.address});
  factory UserDetailsModel.fromMap(Map map) {
    return UserDetailsModel(name: map["name"], address: map["address"]);
  }

  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
      };
}


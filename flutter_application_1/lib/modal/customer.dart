class Customer {
  String? id;
  String? name;
  String? email;
  String? passw;
  String? phone;
  String? address;

  Customer({
    this.id,
    this.name,
    this.email,
    this.passw,
    this.phone,
    this.address,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    passw = json['passw'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['passw'] = passw;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}

class Appliance {
  String? name;
  int? state;
  String? sId;

  Appliance({this.name, this.state, this.sId});

  Appliance.fromJson(Map<String, dynamic> json, name) {
    name = json['name'];
    state = json['state'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['state'] = this.state;
    data['_id'] = this.sId;
    return data;
  }
}

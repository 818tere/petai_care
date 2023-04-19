class HospitalDataModel {
  int? id;
  String? imageUrl;
  String? name;
  String? address;
  String? number;

  HospitalDataModel(
      {this.id, this.imageUrl, this.name, this.address, this.number});

  HospitalDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    address = json['address'];
    number = json['number'];
  }
}

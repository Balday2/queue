
import 'dart:convert';

List<CarnetModel> carnetModelFromJson(String str) => List<CarnetModel>.from(json.decode(str).map((x) => CarnetModel.fromJson(x)));

// String carnetModelToJson(List<CarnetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CarnetModel {
  late String? id;
  late String? idPassport;
  late String? code;
  late String? nom;
  late String? prenom;
  late String? telephone;
  late String? numero;
  late String? date;
  late String? createdAt;
  late String? updatedAt;

  CarnetModel({
       this.id,
       this.idPassport,
       this.code,
       this.nom,
       this.prenom,
       this.telephone,
       this.numero,
       this.date,
       this.createdAt,
       this.updatedAt
  });

  CarnetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idPassport = json['id_carnet'];
    code = json['code'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
    numero = json['numero'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_carnet'] = idPassport;
    data['code'] = code;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['telephone'] = telephone;
    data['numero'] = numero;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

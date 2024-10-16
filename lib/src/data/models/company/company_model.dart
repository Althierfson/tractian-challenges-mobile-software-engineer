import 'package:challenge_tractian/src/domain/entities/company/company.dart';

class CompanyModel {
  final String id;
  final String name;

  CompanyModel({required this.id, required this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Company toEntity() {
    return Company(id: id, name: name);
  }
}
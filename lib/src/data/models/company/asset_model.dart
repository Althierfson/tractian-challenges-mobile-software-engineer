import 'package:challenge_tractian/src/domain/entities/company/asset_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/base_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/component_node.dart';

class AssetModel {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  AssetModel({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
    );
  }

  BaseNode toNode() {
    if (sensorType != null) {
      return ComponentNode(
          sensorId: sensorId!,
          sensorType: sensorType!,
          status: status!,
          gatewayId: gatewayId!,
          id: id,
          name: name,
          parentId: parentId,
          locationId: locationId);
    } else {
      return AssetNode(id: id, name: name, parentId: parentId);
    }
  }
}

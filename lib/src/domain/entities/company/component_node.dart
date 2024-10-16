import 'package:challenge_tractian/src/domain/entities/company/asset_base_node.dart';

class ComponentNode extends AssetBaseNode {
  final String sensorId;
  final String sensorType;
  final String status;
  final String gatewayId;

  ComponentNode({
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    super.locationId,
    required super.id,
    required super.name,
    super.parentId,
  });
}

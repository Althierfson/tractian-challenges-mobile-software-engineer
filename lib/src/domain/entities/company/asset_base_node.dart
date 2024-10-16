import 'package:challenge_tractian/src/domain/entities/company/base_node.dart';

class AssetBaseNode extends BaseNode {
  final String? locationId;
  AssetBaseNode({required super.id, required super.name, super.parentId, this.locationId});
}

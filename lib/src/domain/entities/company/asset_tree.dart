import 'package:challenge_tractian/src/domain/entities/company/base_node.dart';

class AssetTree {
  BaseNode value;
  List<AssetTree> children;

  AssetTree(this.value) : children = <AssetTree>[];

  String get name => value.name;
  String get id => value.id;

  void addChild(AssetTree child) {
    children.add(child);
  }
}

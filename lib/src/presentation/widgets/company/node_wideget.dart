import 'package:challenge_tractian/src/domain/entities/company/asset_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/domain/entities/company/component_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/location_node.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/asset_node_widget.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/component_node_widget.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/location_node_widget.dart';
import 'package:flutter/material.dart';

class NodeWideget extends StatelessWidget {
  final AssetTree asset;
  final List<Widget>? children;
  final bool hideChildren;
  final Function(String)? onShowAssetTree;
  const NodeWideget(
      {super.key,
      required this.asset,
      this.children,
      this.hideChildren = false,
      this.onShowAssetTree});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: children == null || children!.isEmpty
            ? null
            : const Border(
                left: BorderSide(
                  color: Color(0xff8E98A3),
                  width: 1,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (children == null || children!.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Color(0xff8E98A3),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Color(0xff8E98A3),
                          width: 1,
                        ),
                      ),
                    ),
                    child: const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              if (children != null && children!.isNotEmpty)
                InkWell(
                    onTap: () {
                      if (onShowAssetTree != null) {
                        onShowAssetTree!(asset.id);
                      }
                    },
                    child: Icon(hideChildren ? Icons.arrow_right : Icons.arrow_drop_down)),
              _buildNode(asset),
            ],
          ),
          // if (children != null && !hideChildren)
          for (final child in children!)
            Offstage(
                offstage: children == null || hideChildren,
                child: Container(padding: const EdgeInsets.only(left: 11), child: child)),
        ],
      ),
    );
  }

  Widget _buildNode(AssetTree node) {
    if (node.value is LocationNode) {
      return LocationNodeWidget(location: node.value as LocationNode);
    }
    if (node.value is AssetNode) {
      return AssetNodeWidget(asset: asset.value as AssetNode);
    }
    if (node.value is ComponentNode) {
      return ComponentNodeWidget(component: asset.value as ComponentNode);
    }
    return const SizedBox();
  }
}

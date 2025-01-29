import 'package:challenge_tractian/src/domain/entities/company/asset_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/domain/entities/company/component_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/location_node.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/asset_node_widget.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/component_node_widget.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/location_node_widget.dart';
import 'package:flutter/material.dart';

class NodeWideget extends StatefulWidget {
  final AssetTree asset;
  final List<String> hideTree;
  final Function(String)? onShowAssetTree;
  final bool notFirst;
  const NodeWideget(
      {super.key,
      required this.asset,
      this.hideTree = const [],
      this.onShowAssetTree,
      this.notFirst = true});

  @override
  State<NodeWideget> createState() => _NodeWidegetState();
}

class _NodeWidegetState extends State<NodeWideget> {
  bool showNode = false;

  @override
  void initState() {
    showNode = !widget.hideTree.contains(widget.asset.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                showNode = !showNode;
              });
            },
            child: Row(
              children: [
                if (widget.asset.children.isNotEmpty)
                  showNode ? const Icon(Icons.arrow_drop_down) : const Icon(Icons.arrow_right),
                if (widget.asset.children.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 14,
                      height: 15,
                      decoration: BoxDecoration(
                        border: widget.notFirst
                            ? const Border(
                                left: BorderSide(color: Color(0xffd9d9d9), width: 1),
                                bottom: BorderSide(color: Color(0xffd9d9d9), width: 1))
                            : null,
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                _buildNode(widget.asset),
              ],
            )),
        if (showNode)
          for (final child in widget.asset.children)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xffd9d9d9), width: 1),
                  ),
                ),
                child: NodeWideget(
                  asset: child,
                  hideTree: widget.hideTree,
                  onShowAssetTree: widget.onShowAssetTree,
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildNode(AssetTree node) {
    if (node.value is LocationNode) {
      return LocationNodeWidget(location: node.value as LocationNode);
    }
    if (node.value is AssetNode) {
      return AssetNodeWidget(asset: widget.asset.value as AssetNode);
    }
    if (node.value is ComponentNode) {
      return ComponentNodeWidget(component: widget.asset.value as ComponentNode);
    }
    return const SizedBox();
  }
}

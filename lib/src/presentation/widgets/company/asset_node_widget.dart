import 'package:challenge_tractian/src/domain/entities/company/asset_node.dart';
import 'package:flutter/widgets.dart';

class AssetNodeWidget extends StatelessWidget {
  final AssetNode asset;
  const AssetNodeWidget({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/asset.png",
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(asset.name),
      ],
    );
  }
}

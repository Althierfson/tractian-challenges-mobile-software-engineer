import 'package:challenge_tractian/src/domain/entities/company/component_node.dart';
import 'package:flutter/material.dart';

class ComponentNodeWidget extends StatelessWidget {
  final ComponentNode component;
  const ComponentNodeWidget({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/component.png",
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(component.name),
          const SizedBox(
            width: 10,
          ),
          if (component.status == 'alert')
            const Icon(
              Icons.circle,
              color: Colors.red,
              size: 15,
            ),
          if (component.sensorType == 'energy') const Icon(Icons.bolt, color: Colors.yellow),
        ],
      ),
    );
  }
}

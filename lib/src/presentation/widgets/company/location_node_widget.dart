import 'package:challenge_tractian/src/domain/entities/company/location_node.dart';
import 'package:flutter/widgets.dart';

class LocationNodeWidget extends StatelessWidget {
  final LocationNode location;
  const LocationNodeWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/location.png",
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            location.name,
          ),
        ],
      ),
    );
  }
}

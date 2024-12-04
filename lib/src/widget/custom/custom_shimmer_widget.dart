import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdsShimmerEffect extends StatelessWidget {
  const AdsShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[500]!,
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: VariableUtilities.screenSize.height * 0.25,
        width: VariableUtilities.screenSize.width,
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

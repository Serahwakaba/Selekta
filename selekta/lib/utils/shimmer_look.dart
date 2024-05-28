import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/colors.dart';

class OdiShimmerComponent extends StatelessWidget {
  final double? height;
  const OdiShimmerComponent({super.key,required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height,
        //padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Shimmer.fromColors(
          baseColor: OdiColors().oddBackgroundThemed(context),
          highlightColor: Colors.purple,
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0,top:20.0,left: 10,right: 10),
                child:
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.purple,
                    ),
                    const SizedBox( height:5),

                    Container(
                      height: 5,
                      width: double.infinity,
                      color: Colors.purple,
                    ),
                    const SizedBox( height:5),
                    Container(
                      height: 5,
                      width: double.infinity,
                      color: Colors.purple,
                    ),
                  ],
                )
            ),
            itemCount: 60,
          ),
        ));
  }
}

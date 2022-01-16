import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerAnimation extends StatelessWidget {
  const ShimmerAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 3),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 25,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Shimmer(
                duration: const Duration(seconds: 3), //Default value
                interval: const Duration(
                    milliseconds: 100), //Default value: Duration(seconds: 0)
                color: Colors.white, //Default value
                colorOpacity: 0, //Default value
                enabled: true, //Default value
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.grey,
                ),
              ),
              title: Shimmer(
                duration: const Duration(seconds: 3), //Default value
                interval: const Duration(
                    milliseconds: 100), //Default value: Duration(seconds: 0)
                color: Colors.white, //Default value
                colorOpacity: 0, //Default value
                enabled: true, //Default value
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  height: 10,
                  color: Colors.grey,
                ),
              ),
              subtitle: Shimmer(
                duration: const Duration(seconds: 3), //Default value
                interval: const Duration(
                    milliseconds: 100), //Default value: Duration(seconds: 0)
                color: Colors.white, //Default value
                colorOpacity: 0, //Default value
                enabled: true, //Default value
                direction: const ShimmerDirection.fromLTRB(),
                child: Container(
                  height: 10,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        });
  }
}

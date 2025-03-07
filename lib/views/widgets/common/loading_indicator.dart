import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/constants/color_app.dart';

// ignore: must_be_immutable
class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({super.key, this.size});
  double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 70,
        height: size ?? 70,
        child: SpinKitWaveSpinner(
          size: 60,

          trackColor: ColorApp.borderColor,
          duration: Duration(seconds: 2),
          color: ColorApp.primaryColor,
          // child: svgImage(ImagesUrl.logoSVG, padingValue: 5),
          child: SizedBox(),
          // itemBuilder: (BuildContext context, int index) {
          //   return DecoratedBox(
          //     decoration: BoxDecoration(
          //       color: index.isEven ? Colors.red : Colors.green,
          //     ),
          //   );
          // },

          // Center(
          //     child: CircularProgressIndicator(
          //         color: ColorApp.primaryColor,
          //         backgroundColor: ColorApp.backgroundColor)
        ),
      ),
    );
  }
}

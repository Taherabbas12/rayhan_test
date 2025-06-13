import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/controllers/taxi_controller.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';

import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/images_url.dart';
import '../../../../utils/constants/values_constant.dart';

class RecentAddress extends StatelessWidget {
  RecentAddress({super.key});
  final TaxiController taxiController = Get.find<TaxiController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder:
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
              child: Divider(
                color: ColorApp.textSecondryColor.withAlpha(50),
                height: Values.circle * 0.5,
              ),
            ),
        itemBuilder:
            (context, index) =>
                fivortyLoaction(taxiController.taxiAddresses[index]),
        itemCount: taxiController.taxiAddresses.length,
      ),
    );
  }

  Widget fivortyLoaction(Taxi location) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(Values.circle),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorApp.primaryColor.withAlpha(50),
        ),
        child: Container(
          padding: EdgeInsets.all(Values.circle * 1.3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorApp.primaryColor,
          ),
          child: svgImage(
            ImagesUrl.locationIcon,
            padingValue: 0,
            color: ColorApp.backgroundColor,
            hi: 20,
            wi: 20,
          ),
        ),
      ),
      trailing: svgImage(ImagesUrl.heartIcon, padingValue: 0),
      title: Text(location.name, style: StringStyle.headerStyle),

      subtitle: Text(
        location.addresses.first,
        style: StringStyle.textTable.copyWith(
          color: ColorApp.textSecondryColor,
        ),
      ),
      onTap: () {
        taxiController.selectLocation(location, location.addresses.first);
      },
    );
  }
}

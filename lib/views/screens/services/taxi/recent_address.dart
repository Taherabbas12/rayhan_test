import 'package:flutter/material.dart';
import 'package:rayhan_test/controllers/taxi_controller.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/views/widgets/common/svg_show.dart';

import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/images_url.dart';
import '../../../../utils/constants/values_constant.dart';

class RecentAddress extends StatelessWidget {
  const RecentAddress({super.key});
  TaxiController get taxiController => TaxiController();
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
          padding: EdgeInsets.all(Values.circle),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorApp.primaryColor,
          ),
          child: Icon(Icons.location_on, color: ColorApp.whiteColor),
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

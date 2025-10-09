// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../controllers/market_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/image_slder.dart';
import 'market_list_categores.dart';

class MarketList extends StatelessWidget {
  MarketList({super.key});
  MarketController marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: Values.spacerV),

        Obx(
          () =>
              marketController.sliderImageModel.isEmpty
                  ? SizedBox()
                  : ImageSlider(imageList: marketController.sliderImageModel),
        ),
        SizedBox(height: Values.spacerV),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 1.5),
        //   child: Text('الشركات', style: StringStyle.titleApp),
        // ),
        // SizedBox(height: Values.spacerV),
        // SizedBox(
        //   height: 145,
        //   child: Obx(
        //     () =>
        //         marketController.isLoading.value
        //             ? LoadingIndicator()
        //             : ListView.builder(
        //               scrollDirection: Axis.horizontal,
        //               itemBuilder:
        //                   (context, index) =>
        //                       index == 0
        //                           ? SizedBox(width: 10)
        //                           : SizedBox(
        //                             width: 100,
        //                             height: 100,
        //                             child: viewCategory(
        //                               marketController.marketCategories[index -
        //                                   1],
        //                               marketController,
        //                             ),
        //                           ),
        //               itemCount: marketController.marketCategories.length + 1,
        //             ),
        //   ),
        // ),
        SizedBox(height: Values.spacerV * .2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 1.5),
          child: Text('الاقسام', style: StringStyle.titleApp),
        ),
        SizedBox(height: Values.spacerV),

        MarketListCategores(),

        SizedBox(height: Values.spacerV),
        // Container(
        //   padding: EdgeInsets.only(right: Values.spacerV * 1.5),
        //   height: 40,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,

        //     itemBuilder:
        //         (context, index) =>
        //             viewFilterOption(MarketController.filterOptions[index]),
        //     itemCount: RestaurantController.filterOptions.length,
        //   ),
        // ),
        // Obx(
        //   () =>
        //       marketController.isLoadingRestaurant.value
        //           ? SizedBox(height: 300, child: LoadingIndicator())
        //           : Padding(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: Values.spacerV * 1.5,
        //             ),
        //             child:
        //                 marketController.restaurants.isEmpty
        //                     ? SizedBox(
        //                       height: 300,
        //                       child: Center(
        //                         child: Text(
        //                           'لا توجد مطاعم متاحة في الفئة المحددة',
        //                           style: StringStyle.textLabilBold.copyWith(
        //                             color: ColorApp.textSecondryColor,
        //                           ),
        //                         ),
        //                       ),
        //                     )
        //                     : OrientationBuilder(
        //                       builder: (context, orientation) {
        //                         return MasonryGridView.count(
        //                           crossAxisCount:
        //                               marketController.countView().value,
        //                           physics: PageScrollPhysics(),
        //                           crossAxisSpacing: 10,
        //                           shrinkWrap: true,

        //                           itemBuilder:
        //                               (context, index) => viewRetaurant(
        //                                 marketController.restaurants[index],
        //                               ),
        //                           itemCount:
        //                               marketController.restaurants.length,
        //                         );
        //                       },
        //                     ),
        //           ),
        // ),
      ],
    );
  }

  //       },
  //       child: Obx(
  //         () => Container(
  //           margin: EdgeInsets.all(1),
  //           alignment: Alignment.center,
  //           padding: EdgeInsets.symmetric(
  //             horizontal: Values.spacerV,
  //             vertical: Values.circle * .5,
  //           ),
  //           decoration: BoxDecoration(
  //             // boxShadow: ShadowValues.shadowValuesBlur,
  //             color:
  //                 restaurantController.selectFilterOption.value == category
  //                     ? ColorApp.primaryColor
  //                     : ColorApp.backgroundColor,
  //             border: Border.all(
  //               width: .5,
  //               color:
  //                   restaurantController.selectFilterOption.value == category
  //                       ? ColorApp.primaryColor
  //                       : ColorApp.borderColor,
  //             ),
  //             borderRadius: BorderRadius.circular(Values.spacerV),
  //           ),
  //           child: Text(
  //             category.label,
  //             style: StringStyle.textLabil.copyWith(
  //               color:
  //                   restaurantController.selectFilterOption.value == category
  //                       ? ColorApp.whiteColor
  //                       : ColorApp.backgroundColorContent,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

Widget viewE(IconData icon, String value) {
  return Row(
    children: [
      Icon(icon, color: ColorApp.primaryColor, size: 17),
      SizedBox(width: Values.circle * .5),
      Text(value, style: StringStyle.textLabilBold),
      SizedBox(width: Values.circle * .5),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../data/models/slider_image_model.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/values_constant.dart';

class ImageSlider extends StatelessWidget {
  final List<SliderImageModel> imageList;

  ImageSlider({super.key, required this.imageList}) {
    Get.put(SliderController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SliderController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          carouselController: controller.carouselController,
          options: CarouselOptions(
            height: Values.width * .4,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            autoPlayInterval: Duration(seconds: 4),
            onPageChanged: (index, reason) {
              controller.onPageChanged(index);
            },
          ),
          items:
              imageList.map((model) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(model.img, fit: BoxFit.fitWidth),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withAlpha(100),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),

        SizedBox(height: 10),

        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                imageList.asMap().entries.map((entry) {
                  bool isActive = controller.current.value == entry.key;
                  return GestureDetector(
                    onTap: () => controller.goToPage(entry.key),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: isActive ? 20.0 : 8.0,
                      height: 5.0,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            isActive
                                ? ColorApp.primaryColor
                                : ColorApp.borderColor.withAlpha(100),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

class SliderController extends GetxController {
  var current = 0.obs;
  final carouselController = CarouselSliderController();

  void onPageChanged(int index) {
    current.value = index;
  }

  void goToPage(int index) {
    carouselController.jumpToPage(index);
  }
}

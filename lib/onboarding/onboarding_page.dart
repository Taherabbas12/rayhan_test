import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/color_app.dart';
import 'onboard_model.dart';
import 'onboarding_controller.dart';
 

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  final controller = Get.put(OnBoardingController());

  final List<OnBoardModel> pages = [
    OnBoardModel(
      image: "assets/images/onb1.png",
      title: "تسوّق وانت مرتاح",
      desc:' اختر الي تحتاجه واترك الباقي علينا'
    ),
    OnBoardModel(
      image: "assets/images/onb2.png",
      title: "خلي الطبخ علينا",
      desc:'من المطعم لباب بيتك تجربة أكل سهلة ومريحة'
    ),
    OnBoardModel(
      image: "assets/images/onb3.png",
      title: "ادفع عند الأستلام",
      desc:' في ريحان، تشوف سعر طلبك بوضوح قبل التأكيد، وتكدر تدفع عند الاستلام بكل راحة نحرص على تجربة سهلة وآمنة من أول خطوة لحد ما يوصل طلبك'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(pages[index]);
                },
              ),
            ),

            /// --- المؤشر ---
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentIndex.value == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          controller.currentIndex.value == index
                              ? ColorApp.primaryColor
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// --- الأزرار ---
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeInBack,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.95,
                            end: 1.0,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                    );
                  },

                  child:
                      controller.currentIndex.value == 2
                          ? _buildStartButton()
                          : _buildButtonsRow(),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
Widget _buildButtonsRow() {
    return Row(
      key: const ValueKey("buttons_row"),
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: controller.skip,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: const Text(
                "تخطي",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: controller.nextPage,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: ColorApp.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.center,
              child: const Text(
                "التالي",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildStartButton() {
    return Container(
      key: const ValueKey("start_button"),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: controller.nextPage,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: ColorApp.primaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: const Text(
            "لنبدأ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnBoardModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// الصورة
          SizedBox(height: 260, child: Image.asset(model.image)),

          const SizedBox(height: 20),

          /// العنوان
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          /// الوصف
          Text(
            model.desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

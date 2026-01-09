import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/my_request_controller.dart';
import '../../../../data/models/order_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';

class OrderTrackingScreen extends StatelessWidget {
  OrderTrackingScreen({super.key, this.orderModel});
  final OrderModel? orderModel;
  final MyRequestController myRequestController =
      Get.find<MyRequestController>();

  // قائمة حالات الطلب
  final List<Map<String, dynamic>> orderStatuses = [
    {
      'status': 'pending',
      'title': 'بإنتظار قبول طلبك',
      'icon': Icons.access_time,
    },
    {
      'status': 'preparing',
      'title': 'طلبك قيد التحضير',
      'icon': Icons.restaurant,
    },
    {
      'status': 'picked',
      'title': 'تم إستلام الطلب من قبل السائق',
      'icon': Icons.delivery_dining,
    },
    {
      'status': 'onway',
      'title': 'الطلب في الطريق إليك',
      'icon': Icons.home_outlined,
    },
    {
      'status': 'done',
      'title': 'تم تسليمك الطلب',
      'icon': Icons.inventory_2_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تتبع حالة الطلب',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // النص العلوي
            Text(
              'يمكنك تتبع حالة طلبك من هنا',
              style: StringStyle.headerStyle.copyWith(
                color: ColorApp.primaryColor,
              ),
            ),

            const SizedBox(height: 30),

            // صورة الشخصية
            Image.asset(
              'assets/images/logo.png',
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 40),

            // Timeline
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Values.spacerV * 2),
              child: _buildTimeline(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    final currentStatus = orderModel?.status ?? 'pending';
    final currentIndex = _getStatusIndex(currentStatus);

    return Column(
      children: List.generate(orderStatuses.length, (index) {
        final status = orderStatuses[index];
        final isCompleted = index <= currentIndex;
        final isLast = index == orderStatuses.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الأيقونة على اليسار
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    isCompleted
                        ? ColorApp.primaryColor.withAlpha(30)
                        : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                status['icon'] as IconData,
                color:
                    isCompleted ? ColorApp.primaryColor : Colors.grey.shade400,
                size: 20,
              ),
            ),

            const SizedBox(width: 16),

            // النص في المنتصف
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isCompleted ? Colors.black : Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isCompleted && index <= currentIndex
                        ? _getFormattedDateTime()
                        : '--/--/2024, --:-- PM',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                    textAlign: TextAlign.right,
                  ),
                  if (!isLast) const SizedBox(height: 24),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // الخط والدائرة على اليمين
            Column(
              children: [
                // الدائرة
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isCompleted ? ColorApp.primaryColor : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isCompleted
                              ? ColorApp.primaryColor
                              : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child:
                      isCompleted
                          ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                          : null,
                ),
                // الخط
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color:
                        isCompleted
                            ? ColorApp.primaryColor
                            : Colors.grey.shade300,
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }

  int _getStatusIndex(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'preparing':
        return 1;
      case 'picked':
        return 2;
      case 'onway':
        return 3;
      case 'done':
        return 4;
      default:
        return 0;
    }
  }

  String _getFormattedDateTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}, ${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $period';
  }
}

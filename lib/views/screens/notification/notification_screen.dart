import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/notfication_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotficationController controller = Get.find<NotficationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات', style: StringStyle.headLineStyle2),
        foregroundColor: ColorApp.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.productsShop.isEmpty) {
          return Center(
            child: Text('لا توجد إشعارات', style: StringStyle.headLineStyle2),
          );
        } else {
          final grouped = _groupNotificationsByDate(controller.productsShop);

          return ListView(
            children:
                grouped.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== عنوان اليوم =====
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      // ===== الإشعارات التابعة لليوم =====
                      ...entry.value.map((notification) {
                        DateTime date = DateTime.parse(
                          notification.date.toString(),
                        );

                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  // ---- سهم ----
                                  const SizedBox(width: 8),

                                  // ---- نقطة حالة ----
                                  const CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.green,
                                  ),

                                  const SizedBox(width: 12),

                                  // ---- النص ----
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notification.title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          notification.body,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          DateFormat('hh:mm a').format(date),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[700],
                                  ),

                                  // ---- الأيقونة داخل دائرة ----
                                  // Container(
                                  //   width: 42,
                                  //   height: 42,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.grey[200],
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: const Icon(
                                  //     Icons.star_border,
                                  //     size: 22,
                                  //     color: Colors.black54,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),

                            // ---- فاصل ----
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Divider(
                                color: Colors.grey[300],
                                height: 1,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  );
                }).toList(),
          );
        }
      }),
    );
  }

  // =====================================================================
  // 🔥 تجميع الإشعارات حسب اليوم
  // =====================================================================
  Map<String, List<dynamic>> _groupNotificationsByDate(List notifications) {
    Map<String, List<dynamic>> grouped = {};

    for (var n in notifications) {
      final date = DateTime.parse(n.date.toString());
      final String label = _getDateLabel(date);

      if (!grouped.containsKey(label)) grouped[label] = [];
      grouped[label]!.add(n);
    }
    return grouped;
  }

  // =====================================================================
  // 🔥 تحويل التاريخ إلى (اليوم – البارحة – قبل يومين – 21 ديسمبر...)
  // =====================================================================
  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0) return "اليوم";
    if (diff == 1) return "البارحة";
    if (diff == 2) return "قبل يومين";
    if (diff < 7) return "قبل $diff أيام";

    return DateFormat("d MMMM", "ar").format(date); // مثل 21 ديسمبر
  }
}

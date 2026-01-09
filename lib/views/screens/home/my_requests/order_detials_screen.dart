// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';
import 'package:rayhan_test/views/widgets/more_widgets.dart';
import '../../../../controllers/my_request_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});
  MyRequestController myRequestController = Get.find<MyRequestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (myRequestController.isDetailsLoading.value) {
          return LoadingIndicator();
        }

        final order = myRequestController.selectedOrder.value;

        return SingleChildScrollView(
          padding: EdgeInsets.all(Values.spacerV),
          child: Column(
            children: [
              // المعلومات العامة
              _buildSection(
                title: 'المعلومات العامة',
                child: Column(
                  children: [
                    _buildInfoRow('طريقة الدفع', 'كاش'),
                    _buildInfoRowWithBadge(
                      'حالة الطلب',
                      _getStatusText(order?.status ?? ''),
                    ),
                    _buildInfoRow('رقم العملية', order?.orderNo ?? '---'),
                    _buildInfoRow('المتجر', order?.shopName ?? '---'),
                  ],
                ),
              ),

              SizedBox(height: Values.spacerV),

              // عنوان التوصيل
              _buildSection(
                title: 'عنوان التوصيل',
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorApp.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'منزل أهلي',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'الإفتراضي',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'طرطوس، البلوك 2، البناية 12، الطابق 4...',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Values.spacerV),

              // معلومات الطلبية
              _buildSection(
                title: 'معلومات الطلبية',
                child: Column(
                  children: [
                    if (myRequestController.orderItem.isNotEmpty)
                      _buildOrderItemCard(),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _showProductsBottomSheet();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: ColorApp.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Values.circle),
                          ),
                        ),
                        child: Text(
                          'عرض منتجات الطلب',
                          style: TextStyle(
                            color: ColorApp.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Values.spacerV),

              // ملاحظة عامة حول الطلبية
              _buildSection(
                title: 'ملاحظة عامة حول الطلبية',
                child: Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص. هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ),

              SizedBox(height: Values.spacerV),

              // الخصم على الطلبية
              _buildSection(
                title: 'الخصم على الطلبية',
                child: Column(
                  children: [
                    // خصم خاص
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(Values.circle),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ColorApp.primaryColor.withAlpha(30),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_offer,
                              color: ColorApp.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'خصم خاص 25%',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'NUP15K • صالح حتى 28/12/2024',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // النقاط
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(Values.circle),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ColorApp.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.stars,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '200 نقطة',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'كل 100 نقطة تساوي 1,000 د.ع',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Values.spacerV),

              // معلومات الدفع
              _buildSection(
                title: 'معلومات الدفع',
                child: Column(
                  children: [
                    _buildPriceRow('سعر الطلبات', '${order?.total ?? '0'} د.ع'),
                    _buildPriceRow('التوصيل', '${order?.delivery ?? '0'} د.ع'),
                    if (order?.tax != null && order!.tax != '0')
                      _buildPriceRow('الضريبة', '${order.tax} د.ع'),
                    const Divider(),
                    _buildPriceRow(
                      'المبلغ الكلي',
                      '${order?.finalPrice ?? '0'} د.ع',
                      isBold: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: Values.spacerV * 4),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Values.spacerV),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // التواصل مع الدعم
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorApp.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Values.circle),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'التواصل مع الدعم',
                  style: TextStyle(
                    color: ColorApp.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // تتبع الطلب
                  Get.toNamed(AppRoutes.orderTrackingScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Values.circle),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'تتبع الطلب',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: ColorApp.borderColor),
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Values.spacerV),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Values.circle),
                topRight: Radius.circular(Values.circle),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_up, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: StringStyle.headerStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // المحتوى
          Padding(padding: EdgeInsets.all(Values.spacerV), child: child),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoRowWithBadge(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: ColorApp.primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: ColorApp.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    bool isDiscount = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color:
                  isDiscount
                      ? ColorApp.primaryColor
                      : (isBold ? Colors.black : Colors.grey.shade800),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemCard() {
    final item = myRequestController.orderItem.first;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(Values.circle),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Values.circle),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Values.circle),
              child: imageCached(item.img ?? ''),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: ColorApp.primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${myRequestController.orderItem.length} وجبات',
                        style: TextStyle(
                          color: ColorApp.primaryColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.shop ?? 'ريحان',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: ColorApp.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'بسماية، البلوك 2، البناية 12، الطابق 5، الشقة 30',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProductsBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'منتجات الطلب',
              style: StringStyle.headerStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: myRequestController.orderItem.length,
                itemBuilder: (context, index) {
                  final item = myRequestController.orderItem[index];
                  final quantity = int.tryParse(item.comnt) ?? 1;
                  final currentPrice = double.tryParse(item.price) ?? 0.0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorApp.borderColor),
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Values.circle),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Values.circle),
                            child: imageCached(item.img ?? ''),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.prodname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'الكمية: $quantity',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${formatCurrency(currentPrice.toString())} د.ع',
                                style: TextStyle(
                                  color: ColorApp.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// ترجمة حالة الطلب
  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return 'جديد';
      case 'pending':
        return 'بانتظار القبول';
      case 'accepted':
        return 'تم القبول';
      case 'preparing':
        return 'قيد التحضير';
      case 'ready':
        return 'جاهز للتوصيل';
      case 'onway':
      case 'on_way':
        return 'في الطريق';
      case 'delivered':
        return 'تم التوصيل';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      case 'rejected':
        return 'مرفوض';
      default:
        return status.isNotEmpty ? status : 'غير محدد';
    }
  }
}

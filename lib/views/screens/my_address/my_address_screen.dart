import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_get_all_controller.dart';
import '../../../controllers/my_address_controller.dart';
import '../../../controllers/storage_controller.dart';
import '../../../data/models/user_model.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/style_app.dart';
import '../../../utils/constants/values_constant.dart';
import 'add_address_screen.dart';

class MyAddressesScreen extends StatefulWidget {
  MyAddressesScreen({super.key});

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  final MyAddressController controller = Get.find<MyAddressController>();
  HomeGetAllController homeGetAllController = Get.find<HomeGetAllController>();
  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel.fromJson(StorageController.getAllData());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "عناويني",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "يمكنك إدارة العناوين من هنا من خلال تعديل أو إضافة عنوان",
              style: StringStyle.headerStyle.copyWith(
                color: ColorApp.textSecondryColor,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.addresses.isEmpty) {
                  return const Center(child: Text("لا توجد عناوين بعد"));
                }

                return ListView.builder(
                  itemCount: controller.addresses.length,
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: Values.circle),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Values.circle),
                        border: Border.all(color: ColorApp.borderColor),
                      ),
                      child: ListTile(
                        onTap: () async {
                          await StorageController.updateDataAddressId(
                            address.id,
                          );
                          userModel.addressid = address.id.toString();
                          await homeGetAllController.getAddress();
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                address.nickName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (userModel.addressid == address.id.toString())
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "الافتراضي",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            address.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        // trailing: PopupMenuButton<String>(
                        //   onSelected: (value) {
                        //     if (value == 'edit') {
                        //       // تعديل العنوان
                        //       // يمكنك فتح شاشة تعديل
                        //     } else if (value == 'delete') {
                        //       controller.addresses.removeAt(index);
                        //       // أو يمكنك استدعاء دالة حذف من الـ API
                        //     }
                        //   },
                        //   itemBuilder:
                        //       (context) => [
                        //         const PopupMenuItem(
                        //           value: 'edit',
                        //           child: Row(
                        //             children: [
                        //               Icon(Icons.edit, color: Colors.black54),
                        //               SizedBox(width: 8),
                        //               Text('تعديل'),
                        //             ],
                        //           ),
                        //         ),
                        //         // const PopupMenuItem(
                        //         //   value: 'delete',
                        //         //   child: Row(
                        //         //     children: [
                        //         //       Icon(Icons.delete, color: Colors.red),
                        //         //       SizedBox(width: 8),
                        //         //       Text(
                        //         //         'حذف',
                        //         //         style: TextStyle(color: Colors.red),
                        //         //       ),
                        //         //     ],
                        //         //   ),
                        //         // ),
                        //       ],
                        // ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () => Get.to(() => AddAddressScreen()),
                icon: const Icon(Icons.add, color: Colors.green),
                label: const Text(
                  "إضافة عنوان جديد",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

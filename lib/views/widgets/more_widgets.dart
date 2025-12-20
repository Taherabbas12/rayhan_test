import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayhan_test/data/models/cart_item.dart';
import 'package:rayhan_test/views/widgets/common/loading_indicator.dart';

import '../../controllers/cart_item_controller.dart';
import '../../controllers/my_address_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/images_url.dart';
import '../../utils/constants/style_app.dart';
import '../../utils/constants/values_constant.dart';
import '../screens/my_address/add_address_screen.dart';

getStatusName(v) {
  if (v == 'new') {
    return 'طلب جديد';
  } else if (v == 'get') {
    return 'مقبول';
  } else if (v == 'reg') {
    return 'مرفوض';
  } else if (v == 'subling') {
    return 'قيد التجهيز';
  } else if (v == 'delevery') {
    return 'قيد التوصيل';
  } else if (v == 'return') {
    return 'طلب راجع';
  } else if (v == 'sublied') {
    return 'تم التجهيز';
  } else if (v == 'audit') {
    return 'مدقق';
  } else if (v == 'done') {
    return 'طلب مكتمل';
  } else {
    return '';
  }
}

String calculateTimeDifference(String storedDateString) {
  try {
    // Define the format of the stored date
    DateFormat dateFormat = DateFormat('yyyy-M-d h:mma');

    // Parse the stored date string
    DateTime storedDate = dateFormat.parse(storedDateString);

    DateTime now = DateTime.now();
    Duration difference = now.difference(storedDate);

    if (difference.inDays > 0) {
      return "${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}";
    } else {
      return "الآن";
    }
  } catch (e) {
    return "خطأ في صيغة التاريخ"; // Error in date format
  }
}

String calculateTimeDifferenceWithFormattedTime(String storedDateString) {
  try {
    // تحويل التاريخ من الصيغة ISO 8601 إلى كائن DateTime وضبطه للوقت المحلي
    DateTime storedDate = DateTime.parse(storedDateString).toLocal();

    // حساب الفرق بين التاريخ الحالي والتاريخ المخزن
    DateTime now = DateTime.now();
    Duration difference = now.difference(storedDate);

    // تنسيق الوقت ليظهر بصيغة الساعة AM/PM
    DateFormat timeFormat = DateFormat('h:mm a', 'en_US');
    String formattedTime = timeFormat.format(storedDate);

    // تحديد الفرق الزمني مع إظهار الوقت بصيغة AM/PM
    if (difference.inDays > 0) {
      return "${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'} \n $formattedTime";
    } else if (difference.inHours > 0) {
      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;
      String hourMinuteText = "$hours  ${hours == 1 ? 'ساعة' : 'ساعات'}";
      if (minutes > 0) {
        hourMinuteText += " و $minutes  ${minutes == 1 ? 'دقيقة' : 'دقائق'}";
      }
      return "منذ $hourMinuteText \n $formattedTime";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'} \n $formattedTime";
    } else {
      return "الآن - $formattedTime";
    }
  } catch (e) {
    return "خطأ في صيغة التاريخ"; // رسالة الخطأ في حال فشل التحليل
  }
}

String formatCurrency(String text) {
  final formatter = NumberFormat("#,##0", "ar_IQD");
  return formatter.format(double.parse(text == '' ? '0' : text));
}

String getFormattedDate(String value) {
  DateTime now = DateTime.parse(value);
  String formattedDate = DateFormat('yyyy-M-d h:mma').format(now);
  return formattedDate;
}

String getFormattedDateOnlyDate(String value) {
  DateTime now = DateTime.parse(value);
  String formattedDate = DateFormat('yyyy-M-d').format(now);
  return formattedDate;
}

String getFormattedDateProdect(String value) {
  // تقسيم النص إلى أجزاء
  List<String> parts = value.split('-');

  // التأكد من أن كل جزء يحتوي على رقمين (yyyy-MM-dd)
  String year = parts[0];
  String month = parts[1].padLeft(2, '0'); // إضافة صفر إذا كان أقل من رقمين
  String day = parts[2].padLeft(2, '0'); // إضافة صفر إذا كان أقل من رقمين

  // دمج النصوص لتشكيل تاريخ صالح
  String formattedInput = '$year-$month-$day';

  // تحويل النص إلى كائن DateTime وتنسيقه
  DateTime now = DateTime.parse(formattedInput);
  String formattedDate = DateFormat('yyyy-M-d').format(now);

  return formattedDate;
}

Widget imageCached(
  String urlImage, {
  double? circle,
  bool top = false,
  bool down = false,
  bool left = false,
  bool right = false,
  BoxFit boxFit = BoxFit.cover,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(top || left ? circle ?? Values.circle : 0),
      topRight: Radius.circular(top || right ? circle ?? Values.circle : 0),
      bottomLeft: Radius.circular(down || left ? circle ?? Values.circle : 0),
      bottomRight: Radius.circular(down || right ? circle ?? Values.circle : 0),
    ),
    child:
        urlImage.isNotEmpty
            ? CachedNetworkImage(
              imageUrl: urlImage,
              fit: boxFit,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) =>
                      Center(child: LoadingIndicator()),
              errorWidget:
                  (context, url, error) => Center(
                    child: Image.asset(
                      ImagesUrl.logoPNG,
                      width: 80,
                      height: 80,
                    ),
                  ),
            )
            : SizedBox(
              child: Center(
                child: Image.asset(ImagesUrl.logoPNG, width: 80, height: 80),
              ),
            ),
  );
}

String calculateDaysRemainingWithText(String targetDate) {
  DateTime now = DateTime.now(); // الحصول على التاريخ والوقت الحالي
  DateTime target = DateTime.parse(targetDate); // تحويل النص إلى كائن DateTime

  Duration difference = target.difference(now); // الفرق بين التاريخين
  int daysRemaining = difference.inDays; // عدد الأيام المتبقية

  if (daysRemaining <= 0) {
    return "اليوم هو الموعد أو مرّ الموعد."; // إذا كان التاريخ اليوم أو في الماضي
  }

  // تحديد النص الصحيح بناءً على العدد
  if (daysRemaining == 1) {
    return "يوم واحد متبقٍ.";
  } else if (daysRemaining == 2) {
    return "يومان متبقيان.";
  } else if (daysRemaining >= 3 && daysRemaining <= 10) {
    return "$daysRemaining أيام متبقية.";
  } else {
    return "$daysRemaining يومًا متبقيًا."; // للحالات الأخرى
  }
}

String getFileName(String filePath) {
  return filePath.split('\\').last..split('/').last;
}

// DateColor getColorBasedOnDate(String expirationDate) {
//   if (expirationDate.isEmpty) {
//     return DateColor(Colors.black, ''); // لون افتراضي إذا لم يكن هناك تاريخ
//   }

//   try {
//     // تحويل التاريخ إلى تنسيق صحيح YYYY-MM-DD
//     List<String> parts = expirationDate.split('-');
//     String formattedDate =
//         "${parts[0]}-${parts[1].padLeft(2, '0')}-${parts[2].padLeft(2, '0')}";

//     // تحويل النص إلى كائن DateTime
//     DateTime expiry = DateTime.parse(formattedDate);
//     DateTime now = DateTime.now(); // التاريخ الحالي
//     int differenceInDays = expiry.difference(now).inDays; // الفارق بالأيام
//     String va = getFormattedDateProdect(formattedDate);
//     if (differenceInDays < 0) {
//       return DateColor(
//           ColorApp.redColor, 'منتهي الصلاحية\n$va'); // انتهى الصلاحية
//     } else if (differenceInDays <= 10) {
//       return DateColor(ColorApp.textFourColor, va); // أقل من 10 أيام
//     } else if (differenceInDays <= 20) {
//       return DateColor(
//           ColorApp.backgroundColorContent, formattedDate); // بين 10 - 20 يوم
//     } else {
//       return DateColor(ColorApp.greenColor, va); // أكثر من 20 يوم
//     }
//   } catch (e) {
//     return DateColor(
//         ColorApp.backgroundSliderMenu, ''); // لون افتراضي إذا كان هناك خطأ
//   }
// }

// class DateColor {
//   String value;
//   Color color;
//   DateColor(this.color, this.value);
// }
Widget imageCircle(double size, String urlImage) {
  return SizedBox(
    height: size + 4,
    width: size + 4,
    child: CircleAvatar(
      backgroundColor: ColorApp.primaryColor,
      child: SizedBox(
        height: size,
        width: size,
        child: CircleAvatar(
          backgroundColor: ColorApp.whiteColor,
          child: SizedBox(
            height: size - 4,
            width: size - 4,
            child: CircleAvatar(backgroundImage: AssetImage(urlImage)),
          ),
        ),
      ),
    ),
  );
}

void showImagePicker({
  required void Function() onPressedCamera,
  required void Function() onPressedGallery,
}) {
  showCupertinoModalPopup(
    context: Get.context!,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: const Text("اختر صورة"),
        message: const Text("يرجى اختيار مصدر الصورة"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: onPressedCamera,
            child: const Text("الكاميرا"),
          ),
          CupertinoActionSheetAction(
            onPressed: onPressedGallery,
            child: const Text("الاستوديو"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Get.back(),
          child: const Text("إلغاء"),
        ),
      );
    },
  );
}

Widget? cartShowInScreenTotal(CartType cartType) {
  final CartItemController cartItemController = Get.find<CartItemController>();
  cartItemController.loadCart(cartType: cartType);
  return Obx(
    () =>
        cartItemController.cartItems.isNotEmpty
            ? Padding(
              padding: EdgeInsets.all(Values.spacerV * 2),
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.cartItemScreen);
                },
                child: Container(
                  padding: EdgeInsets.all(Values.circle * 1.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorApp.borderColor),
                    borderRadius: BorderRadius.circular(Values.circle * 1.6),
                    color: ColorApp.primaryColor,
                  ),

                  child: Row(
                    children: [
                      Icon(CupertinoIcons.cart, color: ColorApp.whiteColor),
                      SizedBox(width: Values.circle),
                      Text(
                        '${cartItemController.cartItems.length} منتج في السلة ',
                        style: StringStyle.headerStyle.copyWith(
                          color: ColorApp.whiteColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${formatCurrency(cartItemController.total.toString())} د.ع',
                        style: StringStyle.headerStyle.copyWith(
                          color: ColorApp.whiteColor,
                        ),
                      ),
                      SizedBox(width: Values.circle),

                      Icon(Icons.arrow_forward_ios, color: ColorApp.whiteColor),
                    ],
                  ),
                ),
              ),
            )
            : SizedBox(),
  );
}

void showAddressPicker() {
  final controller = Get.find<MyAddressController>();

  showModalBottomSheet(
    context: Get.context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Obx(() {
        if (controller.addresses.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text("لا توجد عناوين محفوظة"),
          );
        }

        return SizedBox(
          height: Get.height * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "اختر عنوانًا",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.addresses.length,
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    return ListTile(
                      title: Text(
                        address.nickName.isNotEmpty
                            ? address.nickName
                            : "عنوان بدون اسم",
                      ),
                      subtitle: Text(
                        "بلوك ${address.blockNo}، بناية ${address.buildingNo}، منزل ${address.homeNo}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // ✅ اختيار العنوان
                        controller.addressSelect(address);
                        try {
                          Get.back(); // إغلاق الـ BottomSheet
                        } catch (e) {
                          //
                        }
                      },
                      selected:
                          controller.addressSelect.value?.id == address.id,
                      selectedTileColor: Colors.green.shade50,
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(Values.circle),
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
              SizedBox(height: 50),
            ],
          ),
        );
      });
    },
  );
}

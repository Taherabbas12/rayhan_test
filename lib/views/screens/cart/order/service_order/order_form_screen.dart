import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/cart_item_controller.dart';
import '../../../../widgets/actions_button.dart';

class OrderFormScreen extends StatelessWidget {
  OrderFormScreen({super.key});
  final CartItemController c = Get.find<CartItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("إكمال الطلب"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildImageUploader(context),
            const SizedBox(height: 16),
            _buildDaySelector(),
            const SizedBox(height: 16),
            _buildTimeSelector(),
            const SizedBox(height: 16),
            _buildNoteBox(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // 🟩 رفع الصور مع المعاينة
  // 🟩 رفع الصور مع عرض مصغرات على الجانب وفتحها بالحجم الكامل عند الضغط
  Widget _buildImageUploader(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📷 إرفاق صور",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // زر رفع الصور
            GestureDetector(
              onTap: () => c.pickImages(context),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, size: 40, color: Color(0xFF0C7B43)),
                    SizedBox(height: 8),
                    Text("رفع صورة", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔹 عرض الصور كقائمة مصغرة
            if (c.images.isNotEmpty)
              Column(
                children: [
                  ...c.images.map((file) {
                    final fileName = file.path.split('/').last;
                    final fileSize = (file.lengthSync() / 1024).toStringAsFixed(
                      1,
                    );

                    return InkWell(
                      onTap: () {
                        // عند الضغط على الصورة أو الاسم
                        showDialog(
                          context: context,
                          builder:
                              (_) => Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    InteractiveViewer(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          file,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        onPressed: () => Get.back(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // 🔸 الصورة المصغّرة
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                file,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),

                            // 🔸 المعلومات (اسم الملف + الحجم)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fileName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "📏 الحجم: $fileSize KB",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 🔸 زر الحذف الصغير بجانب العنصر
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () => c.images.remove(file),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  // 🔻 زر حذف الكل
                  Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: () => c.images.clear(),
                      icon: const Icon(Icons.delete_forever, color: Colors.red),
                      label: const Text(
                        "حذف جميع الصور",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // 📅 اختيار اليوم
  Widget _buildDaySelector() {
    final days = ["اليوم", "غدًا", "بعد غد"];
    return _buildChoiceCard(
      title: "📅 حدد يوم تواجدك",
      options: days,
      selected: c.selectedDay,
    );
  }

  // ⏰ اختيار الوقت
  Widget _buildTimeSelector() {
    final times = ["9 - 12 صباحًا", "3 - 9 مساءً"];
    return _buildChoiceCard(
      title: "⏰ حدد ساعات تواجدك",
      options: times,
      selected: c.selectedTime,
    );
  }

  // 🟦 كروت الاختيار
  Widget _buildChoiceCard({
    required String title,
    required List<String> options,
    required RxString selected,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Obx(
            () => Row(
              children:
                  options.map((opt) {
                    final isSelected = selected.value == opt;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => selected.value = opt,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color(0xFF0C7B43)
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  isSelected
                                      ? const Color(0xFF0C7B43)
                                      : Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              opt,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 📝 الملاحظات
  Widget _buildNoteBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: TextFormField(
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: "اكتب ملاحظتك هنا...",
          border: InputBorder.none,
        ),
        onChanged: (val) => c.orderNote.value = val,
      ),
    );
  }

  // ✅ زر الإرسال
  Widget _buildSubmitButton() {
    return BottonsC.action2("متابعة", c.submitOrder);
  }

  // 🎨 شكل الكارد الأبيض
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';
import 'package:rayhan_test/utils/constants/values_constant.dart';
import '../../../../controllers/favorites_controller.dart';
import '../../../../controllers/restaurant_controller.dart';
import '../../../../data/models/product_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/images_url.dart';
import '../../../widgets/actions_button.dart';
import '../../../widgets/input_text.dart';
import '../../../widgets/more_widgets.dart';

class ViewProductScreen extends StatefulWidget {
  final Product product;

  const ViewProductScreen({super.key, required this.product});

  @override
  State<ViewProductScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ViewProductScreen> {
  int quantity = 1;
  final TextEditingController noteController = TextEditingController();
  RestaurantController restaurantController = Get.find<RestaurantController>();
  FavoritesController favController = Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final double totalPrice =
        product.price2 > 0
            ? product.price2 * quantity
            : product.price1 * quantity;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // صورة المنتج + ايقونات
            Stack(
              children: [
                SizedBox(
                  width: Values.width,
                  child: imageCached(product.image, boxFit: BoxFit.cover),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  left: 10,
                  child: Row(
                    children: [
                      BottonsC.actionIconWithOutColor(
                        Icons.arrow_back,
                        circle: 50,
                        'رجوع',
                        Get.back,
                        size: 25,
                        colorBackgraond: ColorApp.whiteColor,
                        color: ColorApp.primaryColor,
                      ),
                      Spacer(),
                      const SizedBox(width: 10),

                      // BottonsC.actionIconWithOutColor(
                      //   Icons.favorite_border,
                      //   circle: 50,
                      //   'مفضلة',
                      //   () {},
                      //   size: 25,
                      //   colorBackgraond: ColorApp.whiteColor,
                      //   color: ColorApp.primaryColor,
                      // ),
                      // const SizedBox(width: 10),
                      Obx(() {
                        bool isFavorite = favController.allFavorites.any(
                          (e) => e.id == product.id,
                        );

                        return BottonsC.actionSvgWithOutColor(
                          isFavorite
                              ? ImagesUrl.heartIcon
                              : ImagesUrl.heartBorderIcon,
                          circle: 50,
                          'مفضلة',
                          () => favController.toggleFavorite(
                            product: product,
                            vendor: VendorInfo(
                              id:
                                  restaurantController
                                      .restaurantSelect
                                      .value!
                                      .id,
                              name:
                                  restaurantController
                                      .restaurantSelect
                                      .value!
                                      .name,
                            ),
                          ),
                          size: 25,
                          colorBackgraond: ColorApp.whiteColor,
                          color: ColorApp.primaryColor,
                        );
                      }),
                      SizedBox(width: Values.circle),

                      BottonsC.actionIconWithOutColor(
                        Icons.shopping_cart_outlined,
                        circle: 50,
                        'السلة',
                        () {},
                        size: 25,
                        colorBackgraond: ColorApp.whiteColor,
                        color: ColorApp.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // اسم الوجبة والسعر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: StringStyle.headLineStyle2.copyWith(
                      color: ColorApp.blackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (product.price2 > 0)
                        Text(
                          '${formatCurrency(product.price1.toString())} د.ع',
                          style: const TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Text(
                        '${(product.price2 > 0 ? formatCurrency(product.price2.toString()) : formatCurrency(product.price1.toString()))} د.ع',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // محتوى الوجبة
                  Text(
                    "محتوى الوجبة",
                    style: StringStyle.headerStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.descc,
                    style: StringStyle.headerStyle.copyWith(
                      color: ColorApp.textSecondryColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ملاحظات
                  Text("إضافة ملاحظة", style: StringStyle.headerStyle),
                  const SizedBox(height: 6),
                  InputText.inputStringValidator(
                    'اكتب ملاحظتك هنا.',
                    noteController,
                    maxLine: 7,
                    validator: (p0) => null,
                  ),

                  const SizedBox(height: 20),

                  // كمية الطلب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("كمية الطلب", style: StringStyle.headerStyle),
                      Spacer(),
                      _quantityButton(Icons.add, () {
                        setState(() {
                          quantity++;
                        });
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      _quantityButton(Icons.remove, () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      }),
                    ],
                  ),

                  const SizedBox(height: 100),

                  // زر الإضافة للسلة
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: Values.circle),
        decoration: BoxDecoration(
          color: ColorApp.backgroundColor,
          border: Border.all(color: ColorApp.borderColor.withAlpha(50)),
        ),
        child: Row(
          children: [
            SizedBox(width: Values.spacerV),

            SizedBox(
              width: Values.width * .3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '($quantity) عناصر',
                    style: StringStyle.textLabil.copyWith(
                      color: ColorApp.textSecondryColor,
                    ),
                  ),
                  Text(
                    '${formatCurrency(totalPrice.toString())} د.ع',
                    style: StringStyle.textLabil,
                  ),
                ],
              ),
            ),

            Expanded(
              child: BottonsC.action1(h: 50, 'إضافة للسلة', () {
                restaurantController.addToCart(
                  product,
                  noteController.text,
                  quantity,
                );
              }),
            ),
            SizedBox(width: Values.spacerV),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return BottonsC.actionIconWithOutColor(
      icon,
      '',
      onPressed,
      size: 25,
      circle: 50,

      color: ColorApp.primaryColor,
      colorBackgraond: ColorApp.primaryColor.withAlpha(20),
    );
  }
}

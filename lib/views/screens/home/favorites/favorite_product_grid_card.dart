// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/favorites_controller.dart';
import '../../../../data/models/favorite_product_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import '../../../widgets/more_widgets.dart';

class FavoriteProductGridCard extends StatefulWidget {
  FavoriteProductGridCard({
    super.key,
    required this.product,
    required this.index,
  });

  final FavoriteProduct product;
  final int index;

  @override
  State<FavoriteProductGridCard> createState() =>
      _FavoriteProductGridCardState();
}

class _FavoriteProductGridCardState extends State<FavoriteProductGridCard>
    with SingleTickerProviderStateMixin {
  // زر السلة
  final RxBool isBasket = false.obs;
  FavoritesController favoritesController = Get.find<FavoritesController>();
  // أنميشن إزالة المفضلة (pop + fade)
  late final AnimationController _favCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );
  late final Animation<double> _favScale = CurvedAnimation(
    parent: _favCtrl,
    curve: Curves.elasticOut,
  );
  late final Animation<double> _favFade = CurvedAnimation(
    parent: _favCtrl,
    curve: Curves.easeOut,
  );

  // أنميشن ضغط الكرت
  final RxBool _pressed = false.obs;

  @override
  void dispose() {
    _favCtrl.dispose();
    super.dispose();
  }

  double _discountPercent(Product p) {
    if (p.price2 != 0 && p.price1 != 0) {
      return ((p.price1 - p.price2) / p.price1) * 100;
    }
    return 0;
  }

  Future<void> _removeFromFav(FavoriteProduct p) async {
    // تشغيل انميشن القلب
    await _favCtrl.forward(from: 0);
    // نفّذ إزالة من DB عبر الكنترولر
    final fav = Get.find<FavoritesController>();
    await fav.removeFavorite(p);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discount = _discountPercent(Product.fromFavorite(product));

    // دخول تدريجي مرتب (Fade + Slide) لكل عنصر حسب index
    final int delayMs = 60 + (widget.index % 8) * 60;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      builder: (_, v, child) {
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, (1 - v) * 14),
            child: child,
          ),
        );
      },
      child: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: delayMs)),
        builder: (_, snap) {
          // أثناء التأخير: نخليها مخفية شوي حتى يكون stagger واضح
          final ready = snap.connectionState == ConnectionState.done;

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 240),
            opacity: ready ? 1 : 0,
            child: Obx(() {
              final scale = _pressed.value ? 0.985 : 1.0;

              return AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 140),
                curve: Curves.easeOut,
                child: InkWell(
                  onTapDown: (_) => _pressed.value = true,
                  onTapCancel: () => _pressed.value = false,
                  onTap: () {
                    _pressed.value = false;
                    favoritesController.openProduct(
                      Product.fromFavorite(product),
                    );
                    // Get.to(() => market.ViewProductScreen(product: product));
                    // Get.to(() => resturant.ViewProductScreen(product: product));
                    // Get.to(() => ViewShopProductScreen(product: product));
                  },
                  borderRadius: BorderRadius.circular(Values.circle),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorApp.borderColor, width: 1),
                      borderRadius: BorderRadius.circular(Values.circle),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 14,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                          color: Colors.black.withOpacity(.05),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: Values.circle * .5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              height: 170,
                              width: Values.width,
                              child: Hero(
                                tag: "fav_${product.id}",
                                child: imageCached(
                                  product.image,
                                  top: true,
                                  boxFit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Badge الخصم
                            if (product.price2 != 0)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: _DiscountBubble(
                                  text:
                                      "الخصم\n%${discount.toStringAsFixed(0)}",
                                ),
                              ),

                            // زر إزالة من المفضلة + أنميشن
                            Positioned(
                              top: 10,
                              left: 10,
                              child: GestureDetector(
                                onTap: () => _removeFromFav(product),
                                child: AnimatedBuilder(
                                  animation: _favCtrl,
                                  builder: (_, __) {
                                    final s = 1 + (_favScale.value * .18);
                                    final o = 1 - (_favFade.value * .35);
                                    return Opacity(
                                      opacity: o.clamp(0.0, 1.0),
                                      child: Transform.scale(
                                        scale: s,
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              .35,
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white.withOpacity(
                                                .25,
                                              ),
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // زر أضف للسلة (بنفس مكانك وبأنميشن أجمل)
                            Positioned(
                              bottom: -16,
                              right: 40,
                              left: 40,
                              height: 32,
                              child: InkWell(
                                onTap: () async {
                                  if (isBasket.value) return;
                                  isBasket.value = true;

                                  // Bounce بسيط قبل التنفيذ
                                  await Future.delayed(
                                    const Duration(milliseconds: 220),
                                  );

                                  favoritesController.addCartProduct(product);

                                  await Future.delayed(
                                    const Duration(milliseconds: 350),
                                  );
                                  isBasket.value = false;
                                },
                                borderRadius: BorderRadius.circular(
                                  Values.spacerV,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  curve: Curves.easeOut,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: ColorApp.primaryColor,
                                    borderRadius: BorderRadius.circular(
                                      Values.spacerV,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 16,
                                        offset: const Offset(0, 8),
                                        color: ColorApp.primaryColor
                                            .withOpacity(.25),
                                      ),
                                    ],
                                  ),
                                  child: Obx(
                                    () => AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 220,
                                      ),
                                      switchInCurve: Curves.easeOutBack,
                                      switchOutCurve: Curves.easeIn,
                                      transitionBuilder: (child, anim) {
                                        return ScaleTransition(
                                          scale: Tween(
                                            begin: 0.85,
                                            end: 1.0,
                                          ).animate(anim),
                                          child: FadeTransition(
                                            opacity: anim,
                                            child: child,
                                          ),
                                        );
                                      },
                                      child:
                                          isBasket.value
                                              ? CupertinoActivityIndicator(
                                                key: const ValueKey("loading"),
                                                color: ColorApp.backgroundColor,
                                              )
                                              : Text(
                                                "أضف للسلة",
                                                key: const ValueKey("text"),
                                                style: StringStyle.textLabil
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Values.spacerV * 1.2),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Values.circle,
                            vertical: Values.circle * .5,
                          ),
                          child: Text(
                            product.name,
                            style: StringStyle.textLabil,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Values.circle,
                            vertical: Values.circle * .5,
                          ),
                          child: Text(
                            product.descc,
                            style: StringStyle.textTable,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${product.price2 > 0 ? formatCurrency(product.price2.toString()) : formatCurrency(product.price1.toString())} د.ع",
                                style: StringStyle.textLabilBold.copyWith(
                                  color: ColorApp.primaryColor,
                                ),
                              ),
                            ),
                            if (product.price2 != 0)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Text(
                                  "${product.price1} د.ع",
                                  style: StringStyle.textLabilBold.copyWith(
                                    color: ColorApp.textSecondryColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _DiscountBubble extends StatelessWidget {
  const _DiscountBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 8),
            color: ColorApp.primaryColor.withOpacity(.25),
          ),
        ],
      ),
      child: Text(
        text,
        style: StringStyle.textTable.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

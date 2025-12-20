import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/favorites_controller.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/style_app.dart';
import '../../../../utils/constants/values_constant.dart';
import 'favorite_product_grid_card.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoritesController controller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("المفضلة", style: StringStyle.titleApp)),
      backgroundColor: ColorApp.backgroundColor, // لو عندك أبيض/رمادي حسب الثيم
      body: SafeArea(
        child: Column(
          children: [
            // _TopBar(
            //   title: "المفضلة",
            //   onBack: () => Get.back(),
            //   onSearch: () {},
            // ),
            const SizedBox(height: 8),

            _Tabs(tabIndex: controller.tabIndex, onChanged: controller.setTab),

            const SizedBox(height: 8),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final list = controller.filteredFavorites;

                if (list.isEmpty) {
                  return _EmptyState(onBrowseFood: () => controller.setTab(0));
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Values.circle),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.62, // قريب جداً من كرتك
                        ),
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return FavoriteProductGridCard(
                        product: list[index],
                        index: index,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================== TOP BAR ================== */

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.onBack,
    required this.onSearch,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Values.circle,
        vertical: Values.circle * .6,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onSearch,
            borderRadius: BorderRadius.circular(14),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.search),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: StringStyle.titleApp.copyWith(fontWeight: FontWeight.w900),
          ),
          const Spacer(),
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(14),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================== TABS ================== */

class _Tabs extends StatelessWidget {
  const _Tabs({required this.tabIndex, required this.onChanged});

  final RxInt tabIndex;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Values.circle),
        child: Row(
          children: [
            _TabItem(
              title: "الطعام",
              active: tabIndex.value == 0,
              onTap: () => onChanged(0),
            ),
            _TabItem(
              title: "المتاجر",
              active: tabIndex.value == 1,
              onTap: () => onChanged(1),
            ),
            _TabItem(
              title: "الماركت",
              active: tabIndex.value == 2,
              onTap: () => onChanged(2),
            ),
          ],
        ),
      );
    });
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.title,
    required this.active,
    required this.onTap,
  });

  final String title;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? ColorApp.primaryColor : ColorApp.borderColor,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: StringStyle.textLabilBold.copyWith(
              color:
                  active ? ColorApp.primaryColor : ColorApp.textSecondryColor,
            ),
          ),
        ),
      ),
    );
  }
}

/* ================== EMPTY ================== */

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onBrowseFood});
  final VoidCallback onBrowseFood;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Values.circle * 1.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.7, end: 1),
              duration: const Duration(milliseconds: 650),
              curve: Curves.elasticOut,
              builder: (_, v, child) => Transform.scale(scale: v, child: child),
              child: Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp.borderColor, width: 2),
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: 40,
                  color: ColorApp.primaryColor,
                ),
              ),
            ),
            SizedBox(height: Values.spacerV * 2),
            Text(
              "المفضلة فارغة",
              style: StringStyle.titleApp.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: Values.spacerV),
            Text(
              "لم يتم الاضافة الى المفضلة بعد تصفح وابحث عن المنتجات المميزة واضفها الى المفضلة",
              textAlign: TextAlign.center,
              style: StringStyle.textTable.copyWith(height: 1.7),
            ),
            SizedBox(height: Values.spacerV * 2),
          ],
        ),
      ),
    );
  }
}

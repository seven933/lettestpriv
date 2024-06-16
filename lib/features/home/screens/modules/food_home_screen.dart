import 'package:flutter/material.dart';
import 'package:sixam_mart/features/home/widgets/views/category_view.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/features/home/widgets/bad_weather_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/best_reviewed_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/best_store_nearby_view.dart';
import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
import 'package:sixam_mart/features/home/widgets/views/just_for_you_view.dart';
import 'package:sixam_mart/features/home/widgets/views/most_popular_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/styles.dart';

class FoodHomeScreen extends StatelessWidget {
  const FoodHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthHelper.isLoggedIn();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.foodModuleBannerBg),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          children: [
            BadWeatherWidget(),

            BannerView(isFeatured: false),
            SizedBox(height: 12),
          ],
        ),
      ),

      // - Barra com módulos
      CustomInkWell(
          onTap: null,//() => splashController.switchModule(0, true),
          radius: 30.0, 
          child: GetBuilder<SplashController>(builder: (splashController) {
            return Column(
              children: [
                Container(
                  width: 60.0, 
                  height: 60.0,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0), 
                ),
                child: ClipOval(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      CustomImage(
                          image: '${splashController.configModel!.baseUrls!.moduleImageUrl}/${splashController.moduleList![0].icon}',
                          height: 50,
                          width: 50,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Center(
                        child: Text(
                          splashController.moduleList![0].moduleName!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                      ),
                    ],
                  ),
              ),
              ),
              ]
            );
        }), 
          
      ),

      const CategoryView(),
      isLoggedIn ? const VisitAgainView(fromFood: true) : const SizedBox(),
      const SpecialOfferView(isFood: true, isShop: false),
      const BestReviewItemView(),
      const BestStoreNearbyView(),
      const ItemThatYouLoveView(forShop: false),
      const MostPopularItemView(isFood: true, isShop: false),
      const JustForYouView(),
      const NewOnMartView(isNewStore: true, isPharmacy: false, isShop: false),
    ]);
  }
}

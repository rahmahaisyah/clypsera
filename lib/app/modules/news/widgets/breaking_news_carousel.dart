import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clypsera/app/modules/news/controllers/news_controller.dart';
import 'breaking_news_card.dart'; 
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; 
import 'package:clypsera/app/shared/theme/app_style.dart';


class BreakingNewsCarousel extends GetView<NewsController> {
  const BreakingNewsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.96); 

    return Obx(() {
      if (controller.isLoadingBreaking.value) {
        return const SizedBox(
          height: 220, 
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (controller.breakingNewsList.isEmpty) {
        return const SizedBox(height: 220, child: Center(child: Text('Tidak ada breaking news.')));
      }
      return Column(
        children: [
          SizedBox(
            height: 200, 
            child: PageView.builder(
              controller: pageController,
              itemCount: controller.breakingNewsList.length,
              onPageChanged: controller.onBreakingNewsPageChanged,
              itemBuilder: (context, index) {
                final article = controller.breakingNewsList[index];
                return BreakingNewsCard(
                  article: article,
                  onTap: () => controller.openArticle(article),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SmoothPageIndicator(
            controller: pageController,
            count: controller.breakingNewsList.length,
            effect: ExpandingDotsEffect( 
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Style.primaryColor,
              dotColor: Colors.grey.shade300,
              spacing: 6,
            ),
          ),
        ],
      );
    });
  }
}
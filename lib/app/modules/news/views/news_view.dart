import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../widgets/breaking_news_carousel.dart';
import '../widgets/recommendation_list_item.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});
  Widget _buildSectionHeader(
      BuildContext context, String title, VoidCallback onSeeMore) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Style.headLineStyle12,
          ),
          InkWell(
            onTap: onSeeMore,
            child: Text(
              'Selengkapnya',
              style: Style.headLineStyle4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Style.whiteColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              'Breaking News',
              () => controller.onSeeMoreTap('Breaking News'),
            ),
            const BreakingNewsCarousel(),
            _buildSectionHeader(
              context,
              'Rekomendation',
              () => controller.onSeeMoreTap('Rekomendasi'),
            ),
            Obx(() {
              if (controller.isLoadingRecommendations.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (controller.recommendationList.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(child: Text('Tidak ada rekomendasi berita.')),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recommendationList.length,
                itemBuilder: (context, index) {
                  final article = controller.recommendationList[index];
                  return RecommendationListItemWidget(
                    article: article,
                    onTap: () => controller.openArticle(article),
                  );
                },
              );
            }),
            const SizedBox(height: 20), // Spasi di akhir body
          ],
        ),
      ),
    );
  }
}

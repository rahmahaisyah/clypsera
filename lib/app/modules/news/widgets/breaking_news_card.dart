import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clypsera/app/data/models/news_article_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:get/get.dart'; 
import 'package:clypsera/app/modules/news/controllers/news_controller.dart';

class BreakingNewsCard extends StatelessWidget {
  final NewsArticleModel article;
  final VoidCallback? onTap;

  const BreakingNewsCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = Get.find<NewsController>().getTimeAgo(article.publishedDate);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85, 
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: article.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(article.imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Style.primaryColorOp4, 
                    BlendMode.darken,
                  ),
                )
              : null,
          color: article.imageUrl == null ? Style.greyColor2 : null,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  gradient: LinearGradient( 
                    colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          article.source ?? 'N/A',
                          style: Style.headLineStyle6,
                        ),
                        if (article.source != null)
                          Padding(
                            
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(CupertinoIcons.checkmark_seal_fill, color: Style.blueColor, size: 18),
                          ),
                        Text(
                          '• $timeAgo',
                          style: Style.headLineStyle6,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.snippet ?? article.title,
                      style: Style.headLineStyle10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                onTap: () {
                  Get.find<NewsController>().toggleBookmark(article);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    article.isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
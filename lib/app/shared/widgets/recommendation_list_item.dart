import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clypsera/app/data/models/news_article_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';

class RecommendationListItemWidget extends StatelessWidget {
  final NewsArticleModel article;
  final VoidCallback? onTap;

  const RecommendationListItemWidget({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat =
        DateFormat('MMM dd, yyyy'); 

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: article.imageUrl != null
                  ? Image.network(article.imageUrl!,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey[400]),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                            width: 90,
                            height: 90,
                            child: Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2)));
                      })
                  : Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(Icons.article_outlined,
                          color: Colors.grey[400], size: 40),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    article.title,
                    style: Style.headLineStyle13,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (article.source != null)
                        Flexible(
                          child: Text(
                            article.source!,
                            style: Style.headLineStyle15,
                          ),
                        ), // Mendorong tanggal ke kanan
                      Text(
                        '• ${dateFormat.format(article.publishedDate)}',
                        style: Style.headLineStyle4,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

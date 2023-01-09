import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/view_models/movie_card_view_model.dart';

class MovieCard extends StatelessWidget {
  final MovieCardViewModel article;
  const MovieCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          article.gotoDetailsScreen(context);
        },
        leading: SizedBox(
          width: 100,
          child: CachedNetworkImage(
            imageUrl: article.posterImageUrl,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
            progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress)),
          ),
        ),
        title: Text(article.title),
        // subtitle: Text(article.overview),
      ),
    );
  }
}

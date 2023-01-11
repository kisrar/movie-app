import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utilities/utilities.dart';

import '../../view_models/view_models.dart';
import '../views.dart';

class MovieCard extends StatelessWidget {
  final MovieCardViewModel movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        movie.gotoDetailsScreen(context);
      },
      child: Card(
        child: GridTile(
          footer: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Text(movie.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
          child: CachedNetworkImage(
            imageUrl: movie.posterImageUrl,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
            progressIndicatorBuilder: (context, url, progress) =>
                const ShimmerContainer(height: 20),
          ),
        ),
        // subtitle: Text(article.overview),
      ).addNeumorphism(),
    );
  }
}

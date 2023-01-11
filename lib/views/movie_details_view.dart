import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utilities/utilities.dart';

import '../view_models/view_models.dart';
import 'views.dart';

class MovieDetailsView extends StatelessWidget {
  final MovieCardViewModel movieCardViewModel;
  const MovieDetailsView({super.key, required this.movieCardViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieCardViewModel.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: movieCardViewModel.largePosterImageUrl,
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
            progressIndicatorBuilder: (context, url, progress) =>
                const ShimmerContainer(height: 600),
          ),
          // const SizedBox(height: 10),
          Text(
            movieCardViewModel.overview,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Colors.black54),
          ).addPadding(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Released on  ',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    TextSpan(
                      text: movieCardViewModel.releaseDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              RatingBarIndicator(
                rating: movieCardViewModel.rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 10,
                itemSize: 15.0,
                // direction: Axis.vertical,
              )
            ],
          ).addPadding(8),
        ],
      )),
    );
  }
}

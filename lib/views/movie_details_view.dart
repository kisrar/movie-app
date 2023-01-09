import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/view_models/movie_card_view_model.dart';

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
            imageUrl: movieCardViewModel.posterImageUrl,
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
            progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress)),
          ),
        ],
      )),
    );
  }
}

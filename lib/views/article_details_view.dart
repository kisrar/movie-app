import 'package:flutter/material.dart';

class ArticleDetailsView extends StatelessWidget {
  final String detailsUrl;
  const ArticleDetailsView({super.key,required this.detailsUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details'),),
      body: Center(child : Text(detailsUrl)),
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/utilities/utilities.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchTEC;
  const SearchBar({super.key,required this.searchTEC});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Timer? _debounce;
  late TextEditingController searchTEC;
  bool showClearIcon = false;

  @override
  void initState() {
    super.initState();
    // searchTEC = TextEditingController();
    searchTEC = widget.searchTEC;

  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchTEC.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, model, _) {
      if (model.showSearchBar) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (_) {
              _debounce?.cancel();
              if (searchTEC.text.isEmpty) {
                  model.getPopularMovies();
                } else {
                  model.searchMovies();
                }
            },
            onChanged: (_) {
              if (searchTEC.text.isNotEmpty && !showClearIcon) {
                setState(() {
                  showClearIcon = true;
                });
              }
              if (searchTEC.text.isEmpty && showClearIcon) {
                setState(() {
                  showClearIcon = false;
                });
              }
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 800), () {
                if (searchTEC.text.isEmpty) {
                  model.getPopularMovies();
                } else {
                  model.searchMovies();
                }
              });
            },
            autofocus: true,
            controller: searchTEC,
            cursorColor: Colors.indigo,
            style: const TextStyle(fontSize: 14.0),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              hintText: 'Search movies ...',
              prefixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.indigo),
                onPressed: () {
                  model.searchMovies();
                },
              ),
              suffixIcon: showClearIcon
                  ? IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.indigo.withOpacity(0.5)),
                      onPressed: () {
                        searchTEC.clear();
                        setState(() {
                          showClearIcon = false;
                        });
                        model.getPopularMovies(isRefresh : true);
                      },
                    )
                  : null,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              isDense: true,
              // fillColor: Color(0xFFEBEDFA),
              fillColor: const Color(0xFFF2F4FC),
            ),
          ),
        ).addNeumorphism();
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}

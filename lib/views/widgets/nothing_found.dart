import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            turns: const AlwaysStoppedAnimation(15 / 360),
            child: FaIcon(
              FontAwesomeIcons.fileVideo,
              color: Colors.grey.withOpacity(0.5),
              size: 100,
            ),
          ),
          const SizedBox(height: 30),
          const Text('Please, try other keywords ....',
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          const Text('No Movies found',
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../data/data.dart';
import 'gaps.dart';

class PostBody extends StatelessWidget {
  const PostBody({
    super.key,
    required this.post,
  });

  final PostDataModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: _parseText(
              text: post.content,
              linkColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        if (post.photoUrl != null) ...[
          GapWidgets.h8,
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: post.photoUrl!,
              fit: BoxFit.fitWidth,
              width: double.infinity,
            ),
          ),
        ],
        GapWidgets.h8,
      ],
    );
  }

  List<TextSpan> _parseText({
    required String text,
    required Color linkColor,
  }) {
    final List<TextSpan> newTexts = [];

    final words = text.split(' ');

    for (final word in words) {
      if (word.startsWith('#')) {
        newTexts.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: linkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle tap here. Use word for condition or navigation.
                debugPrint('Tapped on $word');
              },
          ),
        );
      } else if (word.startsWith('@')) {
        newTexts.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: linkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle tap here. Use word for condition or navigation.
                debugPrint('Tapped on $word');
              },
          ),
        );
      } else if (word.startsWith('http')) {
        newTexts.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: linkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle tap here. Use word for condition or navigation.
                debugPrint('Tapped on $word');
              },
          ),
        );
      } else {
        newTexts.add(
          TextSpan(
            text: '$word ',
          ),
        );
      }
    }

    return newTexts;
  }
}

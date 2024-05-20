import 'package:brainwavesocialapp/common/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.coverImageUrl,
    required this.profileImageUrl,
    required this.uid,
    required this.currentUserId,
  });

  final String coverImageUrl;
  final String profileImageUrl;
  final String uid;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: coverImageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          height: 200,
          errorWidget: (context, url, error) => const SizedBox(
            child: Center(
              child: Text('Error Loading!'),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: CachedNetworkImageProvider(
                    profileImageUrl,
                  ),
                ),
              ),
              if (uid == currentUserId)
                OutlinedButton(
                  onPressed: () {
                    AppRouter.go(
                      context,
                      RouterNames.editProfilePage,
                      pathParameters: {
                        'userId': currentUserId,
                      },
                    );
                  },
                  child: const Text('Edit Profile'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

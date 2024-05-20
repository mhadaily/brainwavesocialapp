import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.name,
    this.bio,
    this.email,
  });

  final String name;
  final String? email;
  final String? bio;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (email != null)
          Text(
            '$email',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        if (bio != null)
          Text(
            bio!,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}

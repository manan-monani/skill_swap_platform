import 'package:flutter/material.dart';

// A widget to display a user's avatar.
class UserAvatar extends StatelessWidget {
  final double radius;
  final String? imageUrl; // The URL of the user's profile image.

  const UserAvatar({super.key, this.radius = 24, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Determine the background image.
    ImageProvider? backgroundImage;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      backgroundImage = NetworkImage(imageUrl!);
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: backgroundImage,
      // If there's no image, show a default person icon.
      child: backgroundImage == null ? Icon(Icons.person, size: radius) : null,
    );
  }
}


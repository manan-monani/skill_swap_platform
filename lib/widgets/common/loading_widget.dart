import 'package:flutter/material.dart';

// A loading widget to be displayed while data is being fetched.
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // A circular progress indicator.
      child: CircularProgressIndicator(),
    );
  }
}

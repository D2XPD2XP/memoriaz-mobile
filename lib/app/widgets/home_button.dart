import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFe0d8cc)),
          ),
          child: const Icon(Icons.home_outlined, size: 32),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GaleryButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GaleryButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFe0d8cc)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.image_outlined,
                size: 20,
                color: Color(0xFF2b2b2b),
              ),
              const SizedBox(width: 10),
              Text(
                'Galeri',
                style: GoogleFonts.hankenGrotesk(
                  color: const Color(0xFF2b2b2b),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

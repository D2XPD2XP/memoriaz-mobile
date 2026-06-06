import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PipelineItem extends StatelessWidget {
  final String label;
  final Color dotColor;

  const PipelineItem({
    super.key,
    required this.label,
    this.dotColor = const Color(0xFFbe6b2a),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFFe0d8cc)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.hankenGrotesk(
              color: const Color(0xFF2b2b2b),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

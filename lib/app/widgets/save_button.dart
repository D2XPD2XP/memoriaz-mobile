import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isProcessing;
  final bool enabled;
  final String label;
  final String processingLabel;

  const SaveButton({
    super.key,
    this.onTap,
    this.isProcessing = false,
    this.enabled = true,
    this.label = 'Simpan ke Galeri',
    this.processingLabel = 'Memproses...',
  });

  @override
  Widget build(BuildContext context) {
    final bool active = enabled && !isProcessing;

    return Opacity(
      opacity: active ? 1.0 : 0.6,
      child: Material(
        color: const Color(0xFFbe6b2a),
        elevation: 2,
        shadowColor: const Color(0xFFbe6b2a).withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: active ? onTap : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isProcessing)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                else
                  const Icon(
                    Icons.download,
                    size: 20,
                    color: Colors.white,
                  ),
                const SizedBox(width: 10),
                Text(
                  isProcessing ? processingLabel : label,
                  style: GoogleFonts.hankenGrotesk(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

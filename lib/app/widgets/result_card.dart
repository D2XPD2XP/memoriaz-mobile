import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultCard extends StatefulWidget {
  final File? beforeImage;
  final File? afterImage;
  final double aspectRatio;

  const ResultCard({
    super.key,
    this.beforeImage,
    this.afterImage,
    this.aspectRatio = 5 / 6,
  });

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  double _position = 0.5;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final dividerX = width * _position;

            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _position = (details.localPosition.dx / width).clamp(
                    0.0,
                    1.0,
                  );
                });
              },
              onTapDown: (details) {
                setState(() {
                  _position = (details.localPosition.dx / width).clamp(
                    0.0,
                    1.0,
                  );
                });
              },
              child: Stack(
                children: [
                  Positioned.fill(child: _buildImage(widget.afterImage)),
                  Positioned.fill(
                    child: ClipRect(
                      clipper: _LeftClipper(_position),
                      child: _buildImage(widget.beforeImage),
                    ),
                  ),
                  Positioned(
                    left: dividerX - 1,
                    top: 0,
                    bottom: 0,
                    child: Container(width: 2, color: Colors.white),
                  ),
                  Positioned(
                    left: dividerX - 20,
                    top: 0,
                    bottom: 0,
                    child: Center(child: _buildHandle()),
                  ),
                  Positioned(top: 12, left: 12, child: _buildBadge('SEBELUM')),
                  Positioned(top: 12, right: 12, child: _buildBadge('SESUDAH')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chevron_left, size: 16, color: Color(0xFF2b2b2b)),
          Icon(Icons.chevron_right, size: 16, color: Color(0xFF2b2b2b)),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: text == "SESUDAH"
            ? Color(0xFFbe6b2a)
            : Colors.black.withValues(alpha: 0.52),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: GoogleFonts.hankenGrotesk(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildImage(File? file) {
    if (file != null) {
      return Image.file(file, fit: BoxFit.cover);
    }
    return Container(
      color: const Color(0xFFd6d1c9),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 48, color: Color(0xFFa09890)),
      ),
    );
  }
}

class _LeftClipper extends CustomClipper<Rect> {
  final double fraction;

  _LeftClipper(this.fraction);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(covariant _LeftClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}

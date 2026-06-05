import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoriaz_app/app/widgets/camera_button.dart';
import 'package:memoriaz_app/app/widgets/galery_button.dart';
import 'package:memoriaz_app/app/widgets/original_card.dart';
import 'package:memoriaz_app/app/widgets/process_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 247, 231),
      body: Container(
        padding: EdgeInsets.only(top: 74, right: 24, left: 24, bottom: 68),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFbe6b2a),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.auto_fix_high,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'MemoriaZ',
                  style: GoogleFonts.spectral(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "Hidupkan kembali foto kenanganmu!",
              style: GoogleFonts.hankenGrotesk(
                color: Color(0xFF6f685f),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 18),
            Obx(
              () => OriginalCard(
                imageFile: controller.selectedImage.value,
                onTap: controller.pickFromGallery,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CameraButton(onTap: controller.pickFromCamera),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GaleryButton(onTap: controller.pickFromGallery),
                ),
              ],
            ),
            Spacer(),
            Obx(
              () => ProcessButton(
                onTap: controller.processImage,
                isProcessing: controller.isProcessing.value,
                enabled: controller.selectedImage.value != null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

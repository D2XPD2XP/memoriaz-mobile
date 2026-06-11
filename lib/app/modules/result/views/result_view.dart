import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoriaz_app/app/widgets/home_button.dart';
import 'package:memoriaz_app/app/widgets/pipeline_item.dart';
import 'package:memoriaz_app/app/widgets/result_card.dart';
import 'package:memoriaz_app/app/widgets/save_button.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 247, 231),
      body: Container(
        padding: EdgeInsets.only(top: 74, right: 24, left: 24, bottom: 68),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Hasil Pemulihan',
                style: GoogleFonts.spectral(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Foto kenanganmu berhasil dipulihkan.",
                      style: GoogleFonts.hankenGrotesk(
                        color: Color(0xFF6f685f),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 12),
                    ResultCard(
                      beforeImage: controller.originalImage.value,
                      afterImage: controller.imageToSave.value,
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Icon(
                          Icons.settings_input_composite_rounded,
                          size: 14,
                          color: Color(0xFF9a9389),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "PIPELINE DITERAPKAN",
                          style: GoogleFonts.hankenGrotesk(
                            color: Color(0xFF9a9389),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        PipelineItem(label: "Median Filter"),
                        SizedBox(width: 8),
                        PipelineItem(label: "Gaussian Kernel"),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        PipelineItem(label: "Histogram EQ"),
                        SizedBox(width: 8),
                        PipelineItem(label: "Unsharp Mask"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            Row(
              children: [
                HomeButton(onTap: controller.backToHome),
                SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => SaveButton(
                      onTap: controller.saveToGallery,
                      isProcessing: controller.isSaving.value,
                      enabled: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

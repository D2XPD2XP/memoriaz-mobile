import 'dart:io';

import 'package:gal/gal.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ResultController extends GetxController {
  final Rxn<File> originalImage = Rxn<File>();
  final Rxn<File> imageToSave = Rxn<File>();
  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      originalImage.value = args['original'] as File?;
      imageToSave.value = args['restored'] as File?;
    } else if (args is File) {
      imageToSave.value = args;
    }
  }

  Future<void> saveToGallery() async {
    final file = imageToSave.value;
    if (file == null) {
      Get.snackbar('Tidak ada gambar', 'Tidak ada gambar untuk disimpan.');
      return;
    }

    try {
      isSaving.value = true;

      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          Get.snackbar(
            'Izin diperlukan',
            'Berikan izin penyimpanan untuk menyimpan foto.',
          );
          return;
        }
      }

      await Gal.putImage(file.path, album: 'MemoriaZ');
      Get.snackbar('Berhasil', 'Foto tersimpan ke galeri.');
    } on GalException catch (e) {
      Get.snackbar('Gagal menyimpan', e.type.message);
    } catch (e) {
      Get.snackbar('Gagal menyimpan', '$e');
    } finally {
      isSaving.value = false;
    }
  }

  void backToHome() {
    Get.offAllNamed(Routes.HOME);
  }
}

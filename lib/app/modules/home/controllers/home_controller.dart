import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  /// Foto asli yang dipilih/diambil pengguna.
  final Rxn<File> selectedImage = Rxn<File>();

  /// Foto hasil pemulihan dari pipeline Python.
  final Rxn<File> restoredImage = Rxn<File>();

  /// True selama pipeline Python berjalan.
  final RxBool isProcessing = false.obs;

  /// Jalankan pipeline pemulihan foto (logic penuh dari Python).
  ///
  /// TODO: hubungkan ke backend Python (median/gaussian filter,
  /// morfologi opening/closing, histogram equalization, unsharp masking).
  Future<void> processImage() async {
    final source = selectedImage.value;
    if (source == null) {
      Get.snackbar('Belum ada foto', 'Pilih atau ambil foto terlebih dahulu.');
      return;
    }

    try {
      isProcessing.value = true;
      // TODO: panggil pipeline Python di sini dan set hasilnya.
      // restoredImage.value = await PythonBridge.restore(source.path, ...);
    } catch (e) {
      Get.snackbar('Gagal memproses', '$e');
    } finally {
      isProcessing.value = false;
    }
  }

  /// Ambil foto dari kamera.
  Future<void> pickFromCamera() async {
    final granted = await _ensurePermission(Permission.camera);
    if (!granted) {
      _showPermissionDenied('kamera');
      return;
    }
    await _pick(ImageSource.camera);
  }

  /// Pilih foto dari galeri.
  Future<void> pickFromGallery() async {
    final granted = await _ensureGalleryPermission();
    if (!granted) {
      _showPermissionDenied('galeri');
      return;
    }
    await _pick(ImageSource.gallery);
  }

  Future<void> _pick(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );
      if (picked != null) {
        selectedImage.value = File(picked.path);
      }
    } catch (e) {
      Get.snackbar('Gagal', 'Tidak dapat memuat gambar: $e');
    }
  }

  Future<bool> _ensurePermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted || status.isLimited;
  }

  /// Galeri membutuhkan izin berbeda tergantung versi Android.
  /// Android 13+ memakai READ_MEDIA_IMAGES (Permission.photos),
  /// versi lama memakai READ_EXTERNAL_STORAGE (Permission.storage).
  Future<bool> _ensureGalleryPermission() async {
    if (await _ensurePermission(Permission.photos)) return true;
    return _ensurePermission(Permission.storage);
  }

  void _showPermissionDenied(String target) {
    Get.snackbar(
      'Izin diperlukan',
      'Berikan izin $target di pengaturan untuk melanjutkan.',
      mainButton: TextButton(
        onPressed: openAppSettings,
        child: const Text('Pengaturan'),
      ),
    );
  }
}

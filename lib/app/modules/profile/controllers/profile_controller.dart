import 'package:clypsera/app/data/models/user_profile_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  final Rx<UserProfileModel?> currentUser = Rx<UserProfileModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // TODO: Ganti dengan logika pengambilan data pengguna dari service/API
      // currentUser.value = await _authService.getCurrentUserProfile();

      // Data dummy sesuai desain image_5f7ad7.png
      await Future.delayed(const Duration(seconds: 1));
      currentUser.value = UserProfileModel(
        id: 'user123',
        name: 'Nama kamu',
        email: 'Namakamu23@gmail.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=68',
        gender: Gender.male,
        job: 'Mahasigma',
        dateOfBirth: DateTime(2005, 5, 24),
        phoneNumber: '0857-1633-7149',
        nik: '127183617771666280',
        address: 'Jl. Telekomunikasi, Telkom University.',
      );

      if (currentUser.value == null) {
        errorMessage.value = 'Gagal memuat data profil.';
      }
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: ${e.toString()}";
      print("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String getFormattedDateOfBirth() {
    if (currentUser.value?.dateOfBirth != null) {
      return _dateFormatter.format(currentUser.value!.dateOfBirth!);
    }
    return 'N/A';
  }

  void onNotificationTap() {
    Get.snackbar('Tapped', 'Notifikasi');
  }

  void navigateToEditProfile() {
    if (currentUser.value == null) {
      Get.snackbar('Error', 'Data profil belum dimuat.');
      return;
    }
    Get.snackbar(
        'Navigasi', 'Ke halaman Edit Profil (belum diimplementasikan)');
    //Get.toNamed(Routes.EDIT_PROFILE, arguments: currentUser.value);
  }

  Future<void> logout() async {
    Get.defaultDialog(
        title: "Konfirmasi Logout",
        middleText: "Apakah Anda yakin ingin keluar?",
        textConfirm: "Ya, Keluar",
        textCancel: "Batal",
        confirmTextColor: Style.whiteColor,
        onConfirm: () async {
          // Get.back();
          // isLoading.value = true;
          // await _authService.logout();
          // isLoading.value = false;
          // Get.offAllNamed(Routes.LOGIN);
          Get.snackbar("Logout",
              "Anda telah berhasil keluar (implementasi dibutuhkan).");
          if (Get.isDialogOpen ?? false) Get.back();
        },
        onCancel: () {
          if (Get.isDialogOpen ?? false) Get.back();
        });
  }
}

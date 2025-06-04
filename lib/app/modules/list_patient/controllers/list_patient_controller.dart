import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/uidata.dart'; 
import '../../../data/models/cleft_type_model.dart';
import '../../../data/models/patient_model.dart'; 

class ListPatientController extends GetxController {
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // Daftar asli dari server/sumber data
  final RxList<PatientModel> _allPatients = <PatientModel>[].obs;
  final RxList<CleftTypeModel> allCleftTypes = <CleftTypeModel>[].obs;

  // Daftar yang akan ditampilkan di UI (hasil filter)
  final RxList<PatientModel> filteredPatients = <PatientModel>[].obs;

  // State untuk filter
  final RxString selectedCleftTypeId = ''.obs; // ID dari CleftTypeModel yang dipilih, '' berarti "Semua"

  // Untuk menampilkan beberapa jenis bibir sumbing di filter atau semua
  final RxList<CleftTypeModel> displayedCleftTypesForFilter = <CleftTypeModel>[].obs;
  final RxBool showAllCleftTypesInFilter = true.obs; // Default tampilkan semua untuk filter

  // Tambahkan state isLoading
  final RxBool isLoading = false.obs; // Default false, akan diubah saat memuat data
  final CleftTypeModel _allFilterOption = CleftTypeModel(id: '', name: 'Semua', iconUrl: '');

  @override
  void onInit() {
    super.onInit();
    _performInitialLoad();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      _applyFilters(); // Terapkan filter setiap kali query pencarian berubah
    });
  }

  Future<void> _performInitialLoad() async {
    isLoading.value = true;
    // Simulasi delay untuk memuat data awal
    // Jika _loadInitialData() benar-benar async, await di sini
    _loadInitialData(); 
    _applyFilters(); // Panggil _applyFilters setelah data dimuat dan sebelum UI siap
    // await Future.delayed(const Duration(milliseconds: 50)); // Sedikit delay untuk memastikan UI update jika perlu
    isLoading.value = false;
  }

  void _loadInitialData() {
    // Metode ini sekarang sinkron karena hanya mengisi data dummy
    // Jika ini adalah operasi async (misalnya, dari API), ubah menjadi Future<void>
    // dan kelola isLoading.value di dalamnya.

    allCleftTypes.assignAll([
      CleftTypeModel(id: '1', name: 'Unilateral', iconUrl: unilateralIcon),
      CleftTypeModel(id: '2', name: 'Bilateral', iconUrl: bilateralIcon),
      CleftTypeModel(id: '3', name: 'Palate anatomy', iconUrl: plateAnatomyIcon),
      CleftTypeModel(id: '4', name: 'Cutting marking', iconUrl: cuttingMarkingIcon),
      CleftTypeModel(id: '5', name: 'Syndromic', iconUrl: notifIcon),
      CleftTypeModel(id: '6', name: 'Submucous', iconUrl: notifIcon),
    ]);
    _updateDisplayedCleftTypesForFilter();

    _allPatients.assignAll([
      PatientModel(
          id: 'p1',
          name: 'Nama Cewe A',
          gender: Gender.female,
          cleftDescription: 'Unilateral cleft anatomy',
          date: '4 June'),
      PatientModel(
          id: 'p2',
          name: 'Nama Pria B',
          gender: Gender.male,
          cleftDescription: 'Bilateral cleft anatomy',
          date: '22 June'),
      PatientModel(
          id: 'p3',
          name: 'Nama Cewe C',
          gender: Gender.female,
          cleftDescription: 'Bilateral cleft anatomy',
          date: '4 June'),
      PatientModel(
          id: 'p4',
          name: 'Nama Cowo D',
          gender: Gender.male,
          cleftDescription: 'Palate anatomy',
          date: '22 June'),
      PatientModel(
          id: 'p5',
          name: 'Nama Cewe E',
          gender: Gender.female,
          cleftDescription: 'Unilateral cleft anatomy',
          date: '14 July'),
      PatientModel(
          id: 'p6',
          name: 'Nama Pria F',
          gender: Gender.male,
          cleftDescription: 'Syndromic',
          date: '28 July'),
    ]);
    // filteredPatients.assignAll(_allPatients); // Inisialisasi awal dipindahkan ke _applyFilters
  }

  void _updateDisplayedCleftTypesForFilter() {
    final List<CleftTypeModel> typesToDisplay = [];
    typesToDisplay.add(_allFilterOption);
    if (showAllCleftTypesInFilter.value) {
      displayedCleftTypesForFilter.assignAll(allCleftTypes);
    } else {
      displayedCleftTypesForFilter.assignAll(allCleftTypes.take(3).toList());
    }
  }

  void selectCleftTypeFilter(String cleftTypeId) {
    // Jika ID yang dipilih adalah ID dari _allFilterOption, maka selectedCleftTypeId akan menjadi ''
    selectedCleftTypeId.value = cleftTypeId;
    _applyFilters();
  }

  void _applyFilters() {
    List<PatientModel> tempFiltered = [];
    final currentSearchQuery = searchQuery.value.toLowerCase();
    final currentSelectedTypeId = selectedCleftTypeId.value;

    if (currentSearchQuery.isEmpty && currentSelectedTypeId.isEmpty) {
      tempFiltered.assignAll(_allPatients);
    } else {
      tempFiltered = _allPatients.where((patient) {
        final nameMatches = patient.name.toLowerCase().contains(currentSearchQuery);
        
        bool categoryMatches = true; 
        if (currentSelectedTypeId.isNotEmpty) { // Hanya filter jika ada tipe yang dipilih (bukan "Semua")
          final selectedType = allCleftTypes.firstWhereOrNull((type) => type.id == currentSelectedTypeId);
          if (selectedType != null) {
            categoryMatches = patient.cleftDescription.toLowerCase().contains(selectedType.name.toLowerCase());
          } else {
            // Jika selectedCleftTypeId tidak kosong tapi tidak ditemukan di allCleftTypes (seharusnya tidak terjadi jika data konsisten)
            categoryMatches = false; 
          }
        }
        
        if (currentSearchQuery.isNotEmpty && currentSelectedTypeId.isNotEmpty) {
          return nameMatches && categoryMatches;
        } else if (currentSearchQuery.isNotEmpty) {
          return nameMatches;
        } else if (currentSelectedTypeId.isNotEmpty) { // Ini berarti filter kategori aktif
          return categoryMatches;
        }
        // Jika searchQuery kosong dan selectedCleftTypeId kosong, seharusnya sudah ditangani oleh kondisi pertama.
        // Namun, untuk keamanan, jika sampai sini berarti tidak ada filter aktif.
        return true; 
      }).toList();
    }
    filteredPatients.assignAll(tempFiltered);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

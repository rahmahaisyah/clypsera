import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/uidata.dart';
import '../../../data/models/cleft_type_model.dart';
import '../../../data/models/patient_model.dart';
import '../../../services/core/patient_service.dart';

class ListPatientController extends GetxController {
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  final RxList<PatientModel> _allPatients = <PatientModel>[].obs;
  final RxList<CleftTypeModel> allCleftTypes = <CleftTypeModel>[].obs;
  final RxList<PatientModel> filteredPatients = <PatientModel>[].obs;
  final RxString selectedCleftTypeId = ''.obs;
  final RxList<CleftTypeModel> displayedCleftTypesForFilter =
      <CleftTypeModel>[].obs;
  final RxBool showAllCleftTypesInFilter = true.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      _applyFilters();
    });
    _loadInitialCleftTypes();
  }

  Future<void> fetchPatients() async {
    isLoading.value = true;
    try {
      final patients = await PatientService.fetchPatients();
      _allPatients.assignAll(patients);
      _applyFilters();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data pasien');
    } finally {
      isLoading.value = false;
    }
  }

  void _loadInitialCleftTypes() {
    allCleftTypes.assignAll([
      CleftTypeModel(id: '1', name: 'Unilateral', iconUrl: unilateralIcon),
      CleftTypeModel(id: '2', name: 'Bilateral', iconUrl: bilateralIcon),
      CleftTypeModel(
          id: '3', name: 'Palate anatomy', iconUrl: plateAnatomyIcon),
      CleftTypeModel(
          id: '4', name: 'Cutting marking', iconUrl: cuttingMarkingIcon),
      CleftTypeModel(id: '5', name: 'Syndromic', iconUrl: notifIcon),
      CleftTypeModel(id: '6', name: 'Submucous', iconUrl: notifIcon),
    ]);
    _updateDisplayedCleftTypesForFilter();
  }

  void _updateDisplayedCleftTypesForFilter() {
    if (showAllCleftTypesInFilter.value) {
      displayedCleftTypesForFilter.assignAll(allCleftTypes);
    } else {
      displayedCleftTypesForFilter.assignAll(allCleftTypes.take(3).toList());
    }
  }

  void selectCleftTypeFilter(String cleftTypeId) {
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
        final nameMatches =
            patient.name.toLowerCase().contains(currentSearchQuery);

        bool categoryMatches = true;
        if (currentSelectedTypeId.isNotEmpty) {
          final selectedType = allCleftTypes
              .firstWhereOrNull((type) => type.id == currentSelectedTypeId);
          if (selectedType != null) {
            categoryMatches = patient.cleftDescription
                .toLowerCase()
                .contains(selectedType.name.toLowerCase());
          } else {
            categoryMatches = false;
          }
        }

        if (currentSearchQuery.isNotEmpty && currentSelectedTypeId.isNotEmpty) {
          return nameMatches && categoryMatches;
        } else if (currentSearchQuery.isNotEmpty) {
          return nameMatches;
        } else if (currentSelectedTypeId.isNotEmpty) {
          return categoryMatches;
        }
        return true;
      }).toList();
    }
    filteredPatients.assignAll(tempFiltered);
  }

  bool get isEmptySearch =>
      filteredPatients.isEmpty && searchQuery.value.isNotEmpty;

  bool get isEmptyFilter =>
      filteredPatients.isEmpty &&
      selectedCleftTypeId.value.isNotEmpty &&
      searchQuery.value.isEmpty;

  bool get isEmptyAll =>
      filteredPatients.isEmpty &&
      searchQuery.value.isEmpty &&
      selectedCleftTypeId.value.isEmpty &&
      !isLoading.value;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/uidata.dart';
import '../../../data/models/cleft_type_model.dart';
import '../../../data/models/patient_model.dart';

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
  final CleftTypeModel _allFilterOption =
      CleftTypeModel(id: '', name: 'Semua', iconUrl: '');

  @override
  void onInit() {
    super.onInit();
    _performInitialLoad();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      _applyFilters();
    });
  }

  Future<void> _performInitialLoad() async {
    isLoading.value = true;
    _loadInitialData();
    _applyFilters();
    isLoading.value = false;
  }

  void _loadInitialData() {
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

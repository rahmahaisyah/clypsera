import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_patient_controller.dart';

class DetailPatientView extends GetView<DetailPatientController> {
  const DetailPatientView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPatientView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPatientView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

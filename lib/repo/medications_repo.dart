import 'dart:async';
import 'package:flutter/services.dart';
import 'package:knebelknotes/data/medication.dart';
import 'package:knebelknotes/data/medication_dao.dart';

class MedicationsRepo {
  Future<List<Medication>> fetchMedicationData() async {
    final String meds = await rootBundle.loadString('assets/medication_json.json');
    
   // medList.forEach((med) => MedicationDao.md.insert(med));
    MedicationDao.md.deleteAll();
    return (medicationFromJson(meds)).map((medication) {
      MedicationDao.md.insert(medication);
    }).toList();
  }
}
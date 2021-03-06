import 'dart:developer';

import 'package:knebelknotes/data/app_database.dart';
import 'package:sembast/sembast.dart';
import 'package:knebelknotes/data/medication.dart';

class MedicationDao {
  static const String MEDICATION_STORE_NAME = 'medications';
  static final MedicationDao md = MedicationDao._();
  MedicationDao._();
  final _medicationStore = intMapStoreFactory.store(MEDICATION_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Medication medication) async {
    await _medicationStore.add(await _db, medication.toMap());
  }

  Future update(Medication medication) async {
    final finder = Finder(filter: Filter.byKey(medication.id));
    await _medicationStore.update(
      await _db,
      medication.toMap(),
      finder: finder,
    );
  }

  Future delete(Medication medication) async {
    final finder = Finder(filter: Filter.byKey(medication.id));
    await _medicationStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _medicationStore.delete(await _db);
  }

  Future<List<Medication>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [
      SortOrder('medName'),
    ]);

    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      medication.id = snapshot.key;
      return medication;
    }).toList();
  }

  Future<List<String>> getAllCategories() async {
    final finder = Finder(sortOrders: [SortOrder('cat')]);

    final recordSnapshots =
        await _medicationStore.find(await _db, finder: finder);

    var cat = recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication.cat;
    }).toSet();

    return cat.toList();
  }

  Future<List<Medication>> getMedByClass(String cat) async {
    final finder = Finder(
        filter: Filter.equals('cat', cat),
        sortOrders: [SortOrder('subCat'), SortOrder('medName')]);

    final recordSnapshots =
        await _medicationStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    }).toList();
  }

  Future<List<String>> getAllSubCategories(String cat) async {
    final finder = Finder(
        filter: Filter.equals('cat', cat), sortOrders: [SortOrder('subCat')]);

    final recordSnapshots =
        await _medicationStore.find(await _db, finder: finder);

    var subCat = recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication.subCat;
    }).toSet();
    return subCat.toList();
  }

  Future<List<Medication>> getMedBySubCategory(
      String cat, String subCat) async {
    final finder = Finder(
        filter: Filter.equals('subCat', subCat) & Filter.equals('cat', cat),
        sortOrders: [SortOrder('subCat'), SortOrder('medName')]);

    final recordSnapshots =
        await _medicationStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    }).toList();
  }

  Future<Medication> getMedByName(String med) async {
    final finder = Finder(filter: Filter.equals('medName', med));

    final recordSnapshots =
        await _medicationStore.find(await _db, finder: finder);

    var medication = recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    }).toList();
    if (medication.length > 0) return medication[0];
    return null;
  }

  Future<List<dynamic>> getMedIndications() async {
    Set<String> result = new Set();
    final medicationSnapshot = await _medicationStore.find(await _db);
    medicationSnapshot.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
        medication.indications.map((indication) {
          if (indication.indication.contains('(')) {
            var temp = indication.indication.split(' (');
            result.add(temp[0].toUpperCase());
          } else {
            result.add(indication.indication.toUpperCase());
          }
        }).toList();
    }).toList();

    var resultList = result.toList();
    resultList.sort((a, b) => a.compareTo(b));
    return resultList;
  }
  Future<List<dynamic>> getMedSideEffects() async {
    Set<String> result = new Set();
    final medicationSnapshot = await _medicationStore.find(await _db);
    medicationSnapshot.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
        medication.sideEffects.map((sideEffects) {
          if (sideEffects.sideEffect.contains('(', 1)) {
            var temp = sideEffects.sideEffect.split(' ');
            result.add(temp[1].toUpperCase());
          } else {
            result.add(sideEffects.sideEffect.toUpperCase());
          }
        }).toList();
    }).toList();

    var resultList = result.toList();
    resultList.sort((a, b) => a.compareTo(b));
    return resultList;
  }

    Future<List<dynamic>> getMedSevereEffects() async {
    Set<String> result = new Set();
    final medicationSnapshot = await _medicationStore.find(await _db);
    medicationSnapshot.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
        medication.severeEffects.map((sideEffects) {
          if (sideEffects.severeEffect.contains('(', 1)) {
            var temp = sideEffects.severeEffect.split(' (');
            result.add(temp[0].toUpperCase());
          } else {
            result.add(sideEffects.severeEffect.toUpperCase());
          }
        }).toList();
    }).toList();

    var resultList = result.toList();
    resultList.sort((a, b) => a.compareTo(b));
    return resultList;
  }
}

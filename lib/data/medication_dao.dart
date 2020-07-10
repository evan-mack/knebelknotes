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
    
    final finder = Finder(filter: Filter.notEquals('cat', 'Side Effect Meds') & Filter.notEquals('cat', 'Mood Stabilizer'),sortOrders: [SortOrder('cat')]);
       
    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder: finder
    );

    var cat = recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication.cat;
    }).toSet();

    return cat.toList();
  }


  Future<List<Medication>> getMedByClass(String cat) async{
    final finder = Finder(filter: Filter.equals('cat', cat), sortOrders: [SortOrder('subCat'), SortOrder('medName')]);

    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder:  finder
    );

    return recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    }).toList();
  }

  Future<List<String>> getAllSubCategories(String cat) async {
    final finder = Finder(filter: Filter.equals('cat', cat), sortOrders: [SortOrder('subCat')]);

    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder: finder
    );

    var subCat = recordSnapshots.map((snapshot){
      final medication = Medication.fromMap(snapshot.value);
      return medication.subCat;
    }).toSet();
    return subCat.toList();
  }


   Future<List<Medication>> getMedBySubCategory(String subCat) async{
    final finder = Finder(filter: Filter.equals('subCat', subCat), sortOrders: [SortOrder('subCat'), SortOrder('medName')]);

    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder:  finder
    );

    return recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    }).toList();
  }

  Future<Medication> getMedByName(String med) async {
    final finder = Finder(filter: Filter.equals('medName', med));

    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder:  finder
    );

    var medication = recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    }).toList();
    if(medication.length > 0)
    return medication[0];
    return null;
  }

  Future<bool> medExists(String med) async {
    final finder = Finder(filter: Filter.equals('medName', med));
    final recordSnapshots = await _medicationStore.find(
      await _db,
      finder: finder
    );

    var medication = recordSnapshots.map((snapshot) {
      final medication = Medication.fromMap(snapshot.value);
      return medication;
    });
    return medication.length >= 1;
  }


}



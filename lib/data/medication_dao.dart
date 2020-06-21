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
    await _medicationStore.delete(
      await _db
    );
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
}

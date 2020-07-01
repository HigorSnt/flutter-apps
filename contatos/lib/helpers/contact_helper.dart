import 'package:contatos/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imageColumn = "imageColumn";

class ContactHelper {

  static final ContactHelper _instace = ContactHelper.internal();

  factory ContactHelper() => _instace;

  ContactHelper.internal();

  Database _db;

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contactsNew.db");

    return openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $contactTable("
            "$idColumn: INTEGER PRIMARY KEY,"
            "$nameColumn: TEXT,"
            "$emailColumn: TEXT,"
            "$phoneColumn: TEXT,"
            "$imageColumn: TEXT"
        ")"
      );
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());

    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );

    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(
        contactTable,
        where: "$idColumn = ?",
        whereArgs: [id]
    );
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(
      contactTable,
      contact.toMap(),
      where: "$idColumn = ?",
      whereArgs: [contact.id],
    );
  }
  
  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();

    listMap.forEach((contact) {
      listContact.add(Contact.fromMap(contact));
    });

    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;

    return Sqflite.firstIntValue(
        await dbContact.rawQuery(
            "SELECT COUNT(*) FROM $contactTable"
        )
    );
  }

  Future close() async {
    Database dbContact = await db;
    await dbContact.close();
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDatabase();
    }

    return _db;
  }

}
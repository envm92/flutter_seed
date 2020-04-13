import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seed/models/database.model.dart';

class DataBaseService {

  final Firestore _firestore = Firestore.instance;
  static final DataBaseService _firestoreInstance = new DataBaseService._internal();

  factory DataBaseService() {
    return _firestoreInstance;
  }

  DataBaseService._internal();

  Future<List<DataBaseModel>> getAll(String collection, OptionsModel options) {
    var collRef = getReference(collection, options, null);
    return collRef.getDocuments().then((QuerySnapshot querySnapshot) {
      List<DataBaseModel> list = querySnapshot.documents.map((DocumentSnapshot docSnp) {
        DataBaseModel dbMod = new DataBaseModel(collection);
        dbMod.documentID = docSnp.documentID;
        dbMod.data = docSnp.data;
        return dbMod;
      }).toList();
      return list;
    });
  }

  Future<DataBaseModel> get(DataBaseModel doc, OptionsModel options) {
    DocumentReference docRef = getReference(doc.collection, options, doc.documentID);
    return docRef.get().then((DocumentSnapshot docSnp) {
      doc.data = docSnp.data;
      return doc;
    });
  }

  getRef(DataBaseModel doc, OptionsModel options) {
    return getReference(doc.collection, options, doc.documentID);
  }

  getArrayRef(List<DataBaseModel> docs, OptionsModel options) {
    var list = new List();
    docs.forEach ((doc)=> list.add(this.getRef(doc, options)));
    return list;
  }

  Future<List> getByArrayRef(List<dynamic> arrayRef, collection) async {
    var list = new List();
    var docs = new List();
    await Future.forEach(arrayRef, (reference) async {
      list.add(reference.get());
    }).then((_) async {
      await Future.forEach(list, (element) async {
        await element.then((doc) {
          DataBaseModel dbModel = new DataBaseModel(collection);
          dbModel.documentID = doc.documentID;
          dbModel.data = doc.data;
          dbModel.collection = doc.reference.path;
          docs.add(dbModel);
        });
      });
    });
    return docs;
  }

  Future<DataBaseModel> add(DataBaseModel doc, OptionsModel options) {
    CollectionReference dbRef = getReference(doc.collection, options, null);
    return dbRef.add(doc.data).then((docResponse) {
      doc.documentID = docResponse.documentID;
      return doc;
    });
  }

  Future<dynamic> set(DataBaseModel doc, OptionsModel options) {
    DocumentReference dbRef = getReference(doc.collection, options, doc.documentID);
    return dbRef.setData(doc.data);
  }

  Future<dynamic> update(DataBaseModel doc, OptionsModel options) {
    DocumentReference dbRef = getReference(doc.collection, options, doc.documentID);
    return dbRef.updateData(doc.data);
  }

  getReference(String collection, OptionsModel options, String documentID) {
    var collectionRef;

    if (options != null && options.parent != null) {
      collectionRef = _firestore
          .collection(options.parent.collection)
          .document(options.parent.documentID)
          .collection(collection);
    } else {
      collectionRef = _firestore.collection(collection);
    }

    if (documentID != null) {
      return collectionRef.document(documentID);
    } else {
      if (options != null && options.where != null) {
        options.where.forEach( (clause) {
          switch (clause.operator) {
            case '==':
              collectionRef = collectionRef.where(clause.attribute,
                  isEqualTo: clause.value);
              break;
            case '<':
              collectionRef = collectionRef.where(clause.attribute,
                  isLessThan: clause.value);
              break;
            case '<=':
              collectionRef = collectionRef.where(clause.attribute,
                  isLessThanOrEqualTo: clause.value);
              break;
            case '>':
              collectionRef = collectionRef.where(clause.attribute,
                  isGreaterThan: clause.value);
              break;
            case '>=':
              collectionRef = collectionRef.where(clause.attribute,
                  isGreaterThanOrEqualTo: clause.value);
              break;
          }
        });
      }
      if (options != null && options.orderBy != null) {
        collectionRef = collectionRef.orderBy(options.orderBy.fieldPath,
            descending: (options.orderBy.direction == 'ASC'));
      }
      if (options != null && options.startAfter != null) {
        collectionRef = collectionRef.startAfter(options.startAfter);
      }
      if (options != null && options.limit != null) {
        collectionRef = collectionRef.limit(options.limit);
      }
      return collectionRef;
    }
  }

}
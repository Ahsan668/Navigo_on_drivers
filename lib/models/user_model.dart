
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? phone;
  String? name;
  String? id;
  String? email;
  String? address;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.id,
    this.address
  });

  UserModel.fromDocument(DocumentSnapshot snap){
    phone = (snap as dynamic)["phone"];
    name = (snap as dynamic)["name"];
    id = (snap as dynamic)['id'];
    email = (snap as dynamic)["email"];
    address = (snap as dynamic)["address"];
  }
}
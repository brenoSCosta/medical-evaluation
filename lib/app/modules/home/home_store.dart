import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_triple/flutter_triple.dart';


class HomeStore extends NotifierStore<Exception, int> {
  HomeStore() : super(0);

}

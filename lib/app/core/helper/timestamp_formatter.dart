
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  // var format = new DateFormat().add_Hms(); // <- use skeleton here
  return DateFormat("h:mm MMMM d").format(timestamp.toDate());
}

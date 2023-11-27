//obtener hora en formato text con ISO8601
import 'package:intl/intl.dart';

DateTime dateTime =DateTime.now();
final formattedDate = dateTime.toIso8601String();
//formato precio
NumberFormat numberFormat = NumberFormat('#,###');
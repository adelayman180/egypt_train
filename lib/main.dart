import 'package:flutter/material.dart';
import './home_page.dart';
import './info_page.dart';
import './tickets_page.dart';
import './phone_number_page.dart';
import './result_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      cursorColor: Colors.black,
      primaryColor: Color(0xffD8443C),
      accentColor: Color(0xffD8443C),
    ),
    routes: {
      '/': (_) => HomePage(),
      '/info': (_) => InfoPage(),
      '/tickets': (_) => TicketsPage(),
      '/phone': (_) => PhoneNumberPage(),
      '/result': (_) => ResultPage(),
    },
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/pages/main_page.dart';
import 'package:flutter_cryptocurrency_xrate/provider/cached_currency.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_updating.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CachedCurrency>.value(value: cachedCurrency),
          ChangeNotifierProvider<IsFromSelected>.value(value: isFromSelected),
          ChangeNotifierProvider<IsUpdating>.value(value: isUpdating),
        ],
        child: MainPage(),
      ),
    );
  }
}

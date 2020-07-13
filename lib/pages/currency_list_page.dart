import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/currency_code.dart';

class CurrencyListPage extends StatelessWidget {
  final isFromCurrency;
  final List<String> currencies;

  CurrencyListPage({Key key, @required this.isFromCurrency})
      : currencies = nameToCode.keys.toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFromCurrency ? kDarkColor : kLightColor,
      appBar: _currencyListAppBar(context),
      body: _currencyList(),
    );
  }

  ListView _currencyList() {
    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          title: Text(
            currencies[index],
            style:
                TextStyle(color: isFromCurrency ? Colors.white : Colors.black),
          ),
          subtitle: Text(
            nameToCode[currencies[index]],
            style:
                TextStyle(color: isFromCurrency ? Colors.white : Colors.black),
          ),
        );
      },
    );
  }

  AppBar _currencyListAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: isFromCurrency ? kDarkColor : kLightColor,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isFromCurrency ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: Text(
        'Select Currency',
        style: TextStyle(color: isFromCurrency ? Colors.white : Colors.black),
      ),
    );
  }
}

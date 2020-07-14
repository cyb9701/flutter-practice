import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/currency_code.dart';
import 'package:flutter_cryptocurrency_xrate/provider/cached_currency.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_updating.dart';
import 'package:flutter_cryptocurrency_xrate/service/crypto_compare_api.dart';

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

  AppBar _currencyListAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: isFromCurrency ? kDarkColor : kLightColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: isFromCurrency ? kLightColor : kDarkColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Select Currency',
        style: TextStyle(color: isFromCurrency ? kLightColor : kDarkColor),
      ),
    );
  }

  ListView _currencyList() {
    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            isFromSelected.set(isFromCurrency);
            isUpdating.set(true);
            print('---- IsUpdating: ${isUpdating.get} ----');
            if (isFromCurrency) {
              cachedCurrency.fsym = nameToCode[currencies[index]];
            } else {
              cachedCurrency.tsym = nameToCode[currencies[index]];
            }
            cryptoCompareAPI
                .getCurrency(cachedCurrency.fsym, cachedCurrency.tsym)
                .then(
              (conversion) {
                cachedCurrency.setNewConversion(conversion, isFromCurrency);
                isUpdating.set(false);
              },
            );

            Navigator.pop(context);
          },
          title: Text(
            currencies[index],
            style: TextStyle(
                color: isFromCurrency ? kLightColor : kDarkColor,
                fontSize: 23.0),
          ),
          subtitle: Text(
            nameToCode[currencies[index]],
            style: TextStyle(color: isFromCurrency ? kLightColor : kDarkColor),
          ),
        );
      },
    );
  }
}

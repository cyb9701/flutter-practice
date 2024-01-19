import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/currency_code.dart';
import 'package:flutter_cryptocurrency_xrate/pages/currency_list_page.dart';
import 'package:flutter_cryptocurrency_xrate/pages/input_page.dart';
import 'package:flutter_cryptocurrency_xrate/provider/cached_currency.dart';
import 'package:provider/provider.dart';

class CurrencyWidget extends StatelessWidget {
  final bool isFromCurrency;

  const CurrencyWidget({Key key, @required this.isFromCurrency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CachedCurrency>(
      builder: (context, currency, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _currencyCode(context, currency),
            _sizedBox10(),
            _currencyName(currency),
            _sizedBox20(),
            _currencyValue(context, currency),
          ],
        );
      },
    );
  }

  GestureDetector _currencyCode(BuildContext context, CachedCurrency currency) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrencyListPage(
              isFromCurrency: isFromCurrency,
            ),
          ),
        );
      },
      child: Text(
        isFromCurrency ? currency.fsym : currency.tsym,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: isFromCurrency ? kLightColor : kDarkColor),
      ),
    );
  }

  Text _currencyName(CachedCurrency currency) {
    return Text(
      isFromCurrency ? codeToName[currency.fsym] : codeToName[currency.tsym],
      style: TextStyle(
          color: isFromCurrency ? kLightColor : kDarkColor, fontSize: 20),
    );
  }

  GestureDetector _currencyValue(
      BuildContext context, CachedCurrency currency) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputPage(
              isFromCurrency: isFromCurrency,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AutoSizeText(
          (isFromCurrency ? currency.fvalue : currency.tvalue)
              .toStringAsFixed(2),
          maxLines: 1,
          style: TextStyle(
              color: isFromCurrency ? kLightColor : kDarkColor,
              fontWeight: FontWeight.bold,
              fontSize: 60.0),
        ),
      ),
    );
  }

  SizedBox _sizedBox10() => SizedBox(height: 10.0);

  SizedBox _sizedBox20() => SizedBox(height: 20.0);
}

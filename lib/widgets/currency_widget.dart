import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/currency_code.dart';
import 'package:flutter_cryptocurrency_xrate/pages/currency_list_page.dart';
import 'package:flutter_cryptocurrency_xrate/provider/cached_currency.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
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
            GestureDetector(
              onTap: () {
                if (isFromCurrency) {
                  Provider.of<IsFromSelected>(context, listen: false)
                      .set(isFromCurrency);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrencyListPage(
                        isFromCurrency: isFromCurrency,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                isFromCurrency ? codeToName[currency.fsym] : currency.tsym,
                style: TextStyle(
                    color: isFromCurrency ? Colors.white : Colors.black),
              ),
            ),
            _sizedBox(),
            GestureDetector(
              onTap: () {
                Provider.of<IsFromSelected>(context, listen: false)
                    .set(isFromCurrency);
              },
              child: Text(
                isFromCurrency
                    ? currency.fvalue.toString()
                    : currency.tvalue.toString(),
                style: TextStyle(
                    color: isFromCurrency ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
              ),
            ),
            _sizedBox(),
            GestureDetector(
              onTap: () {
                if (isFromCurrency == false) {
                  Provider.of<IsFromSelected>(context, listen: false)
                      .set(isFromCurrency);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrencyListPage(
                        isFromCurrency: isFromCurrency,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                isFromCurrency ? currency.fsym : codeToName[currency.tsym],
                style: TextStyle(
                    color: isFromCurrency ? Colors.white : Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  SizedBox _sizedBox() => SizedBox(height: 20.0);
}

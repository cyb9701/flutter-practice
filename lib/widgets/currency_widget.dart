import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
import 'package:provider/provider.dart';

class CurrencyWidget extends StatelessWidget {
  final bool isFromCurrency;

  const CurrencyWidget({Key key, @required this.isFromCurrency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (isFromCurrency) {
              Provider.of<IsFromSelected>(context, listen: false)
                  .setSelected(isFromCurrency);
            }
          },
          child: Text(isFromCurrency ? 'Currency' : 'usd'),
        ),
        _sizedBox(),
        GestureDetector(
          onTap: () {
            Provider.of<IsFromSelected>(context, listen: false)
                .setSelected(isFromCurrency);
          },
          child: Text('0000'),
        ),
        _sizedBox(),
        GestureDetector(
          onTap: () {
            if (isFromCurrency == false) {
              Provider.of<IsFromSelected>(context, listen: false)
                  .setSelected(isFromCurrency);
            }
          },
          child: Text(isFromCurrency ? 'usd' : 'Currency'),
        ),
      ],
    );
  }

  SizedBox _sizedBox() => SizedBox(height: 20.0);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/size.dart';
import 'package:flutter_cryptocurrency_xrate/provider/cached_currency.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_updating.dart';
import 'package:flutter_cryptocurrency_xrate/service/crypto_compare_api.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class InputPage extends StatefulWidget {
  final isFromCurrency;

  const InputPage({Key key, this.isFromCurrency}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _maskedTextController = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: '');

  @override
  void initState() {
    _maskedTextController.value = TextEditingValue(
        text: (widget.isFromCurrency
                ? cachedCurrency.fvalue
                : cachedCurrency.tvalue)
            .toStringAsFixed(2));
    super.initState();
  }

  @override
  void dispose() {
    _maskedTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.isFromCurrency ? kDarkColor : kLightColor,
      appBar: _inputPageAppBar(context),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _textFormField(),
              _gridBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _inputPageAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: widget.isFromCurrency ? kDarkColor : kLightColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: widget.isFromCurrency ? kLightColor : kDarkColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        widget.isFromCurrency ? cachedCurrency.fsym : cachedCurrency.tsym,
        style:
            TextStyle(color: widget.isFromCurrency ? kLightColor : kDarkColor),
      ),
    );
  }

  Expanded _textFormField() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Align(
          alignment: Alignment.center,
          child: TextFormField(
            controller: _maskedTextController,
            maxLines: 2,
            enabled: false,
            textAlign: TextAlign.center,
            decoration: InputDecoration(border: InputBorder.none),
            style: TextStyle(
                color: widget.isFromCurrency ? kLightColor : kDarkColor,
                fontSize: 60),
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(20),
              BlacklistingTextInputFormatter.singleLineFormatter,
            ],
          ),
        ),
      ),
    );
  }

  GridView _gridBtn(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(30),
      crossAxisCount: 3,
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      shrinkWrap: true,
      children: List.generate(12, (index) {
        return SizedBox(
          width: (size.width - 120) / 3,
          height: (size.width - 120) / 3,
          child: FlatButton(
            onPressed: () {
              if (index < 9) {
                _maskedTextController.text =
                    _maskedTextController.text + inputButton(index);
              } else {
                switch (index) {
                  case 9:
                    _maskedTextController.text = _maskedTextController.text
                        .substring(0, _maskedTextController.text.length - 1);
                    break;
                  case 10:
                    _maskedTextController.text =
                        _maskedTextController.text + inputButton(index);
                    break;
                  case 11:
                    isUpdating.set(true);
                    if (widget.isFromCurrency) {
                      cachedCurrency.setNewFValue(
                          double.parse(_maskedTextController.text));
                    } else {
                      cachedCurrency.setNewTValue(
                          double.parse(_maskedTextController.text));
                    }
                    isFromSelected.set(widget.isFromCurrency);
                    cryptoCompareAPI
                        .getCurrency(cachedCurrency.fsym, cachedCurrency.tsym)
                        .then(
                      (conversion) {
                        cachedCurrency.setNewConversion(
                            conversion, widget.isFromCurrency);
                        isUpdating.set(false);
                      },
                    );
                    Navigator.of(context).pop();
                    break;
                }
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular((size.width - 120) / 6)),
            color: widget.isFromCurrency ? kLightColor : kDarkColor,
            splashColor: widget.isFromCurrency ? kLightColor : kDarkColor,
            child: getButtonContent(index),
          ),
        );
      }),
    );
  }

  Widget getButtonContent(int index) {
    if (index < 9) {
      return Text(
        inputButton(index),
        style: TextStyle(
            color: widget.isFromCurrency ? kDarkColor : kLightColor,
            fontSize: 24),
      );
    } else {
      switch (index) {
        case 9:
          return Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: kBtnColor,
          );
        case 10:
          return Text(
            inputButton(index),
            style: TextStyle(
                color: widget.isFromCurrency ? kDarkColor : kLightColor,
                fontSize: 24),
          );
        case 11:
          return Icon(
            Icons.done,
            size: 35,
            color: kBtnColor,
          );
      }
    }
  }

  String inputButton(int index) {
    switch (index) {
      case 0:
        return '1';
      case 1:
        return '2';
      case 2:
        return '3';
      case 3:
        return '4';
      case 4:
        return '5';
      case 5:
        return '6';
      case 6:
        return '7';
      case 7:
        return '8';
      case 8:
        return '9';
      case 10:
        return '0';
      default:
        return '';
    }
  }
}

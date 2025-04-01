/*
* @overview: 组件-输入限制
* @Author: rcc 
* @Date: 2023-01-13 14:25:37 
*/

import 'package:flutter/services.dart';

class RcInputFormatters {
  RcInputFormatters._();

  /// 字母数字
  static final List<TextInputFormatter> alphanumeric = [
    FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]')),
  ];

  /// 纯数字
  static final List<TextInputFormatter> digitsOnly = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  /// 非中文
  static final List<TextInputFormatter> others = [
    FilteringTextInputFormatter.allow(RegExp('[^\u4E00-\u9FA5\uF900-\uFA2D\u0020]')),
  ];

  /// 正整数
  static final List<TextInputFormatter> integerPositive = [
    FilteringTextInputFormatter.digitsOnly,
    IntegerInputFormatter(),
  ];

  /// 小数(8位)
  static final List<TextInputFormatter> decimal8 = [
    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
    DecimalInputFormatter(),
  ];

  /// 小数(6位)
  static final List<TextInputFormatter> decimal6 = [
    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
    DecimalInputFormatter(decimal: 6),
  ];

  /// 小数(4位)
  static final List<TextInputFormatter> decimal4 = [
    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
    DecimalInputFormatter(decimal: 4),
  ];

  /// 小数(2位)
  static final List<TextInputFormatter> decimal2 = [
    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
    DecimalInputFormatter(decimal: 2),
  ];

  /// 助记词
  static final List<TextInputFormatter> mnemonic = [
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
    MnemonicInputFormatter(),
  ];
}

class RcKeyboardType {
  static const decimal = TextInputType.numberWithOptions(decimal: true);
  
}

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({
    this.integer = 9,
    this.decimal = 8,
  });

  final int integer;
  final int decimal;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    int offset = newValue.selection.end;

    final List<String> texts = text.split('.');

    /// 多个点
    final bool isMultiplePoints = texts.length > 2;

    /// 多个零开头
    final bool isMultipleZeros = RegExp(r'^0[\d*]+$').hasMatch(text);

    /// 整数超长
    final bool isIntegerExcess = texts.first.length > integer;

    /// 小数超长
    final bool isDecimalExcess = texts.length == 2 && texts.last.length > decimal;

    if (text == '.') {
      text = '0.';
      offset++;
    } else if (isMultipleZeros || isMultiplePoints || isIntegerExcess || isDecimalExcess) {
      text = oldValue.text;
      offset = oldValue.selection.end;
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class IntegerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (RegExp(r'^0').hasMatch(value)) {
      value = '';
      selectionIndex = oldValue.selection.end;
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class MnemonicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value == ' ') {
      value = '';
      selectionIndex = oldValue.selection.end;
    } else if (value.contains('  ')) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

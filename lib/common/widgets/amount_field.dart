
import 'package:flutter/material.dart';

class AmountField extends StatefulWidget {
  const AmountField({super.key});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          // hint: '\$0.0',
          // hasBorder: false,
          // fillColor: Colors.transparent,
          // preffix: TextView(text: '\$', fontSize: 18),
          ),
    );
  }
}

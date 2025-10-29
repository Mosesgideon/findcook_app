import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/text_view.dart';
import 'package:flutter/material.dart';
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(

        tittle: TextView(text: "Transactions",fontSize: 18,fontWeight: FontWeight.w600,),
      ),
    );
  }
}

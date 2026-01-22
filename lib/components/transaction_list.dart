import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
      ),
    );
  }
}

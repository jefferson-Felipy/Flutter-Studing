import 'package:flutter/material.dart';
import 'package:open_editor/components/transaction_item.dart';
import 'package:open_editor/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.removeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Center(child: Text('Transações')),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tr = transactions[index];

                  return TransactionItem(
                    key: GlobalObjectKey(tr),
                    tr: tr,
                    removeTransaction: removeTransaction,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

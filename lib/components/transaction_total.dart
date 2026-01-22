import 'package:flutter/material.dart';

class TransactionTotal extends StatelessWidget {
  const TransactionTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //A linha ocupa todo o espaço disponível na horizontal_
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Total'), Text('00.00')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_editor/components/transaction_chartBar.dart';
import 'package:open_editor/models/transaction.dart';

class TransactionChart extends StatefulWidget {
  final List<Transaction> recentTransactions;

  const TransactionChart({super.key, required this.recentTransactions});

  @override
  State<TransactionChart> createState() => TransactionChartState();
}

class TransactionChartState extends State<TransactionChart> {
  List<Map<String, Object>> get structureObjectChart {
    return List.generate(7, (index) {
      final totalWeek = widget.recentTransactions.fold(
        0.0,
        (initial, cond) => initial + cond.value,
      );

      //Listagem do dia atual ate os anteriores de acordo com o seu index_
      final days = DateTime.now().subtract(Duration(days: index));

      final letterDay = DateFormat.E().format(days)[0];

      double totalSum = 0.0;

      widget.recentTransactions
          .where((tr) {
            return tr.date.day == days.day &&
                tr.date.month == days.month &&
                tr.date.year == days.year;
          })
          .fold(0.0, (initial, cond) => totalSum += cond.value);

      final percentage = totalSum > 0.0 ? (totalSum / totalWeek) : 0.0;

      return {"value": totalSum, "percentage": percentage, "day": letterDay};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //A coluna ocupa todo espaço disponível na Vertical_
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: structureObjectChart.map((tr) {
                    return TransactionChartbar(
                      valueChart: double.parse(tr["value"].toString()),
                      percentage: double.parse(tr["percentage"].toString()),
                      day: tr["day"].toString(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

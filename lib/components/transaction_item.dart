import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_editor/components/adaptatives/adaptative_dialog.dart';
import 'package:open_editor/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String) removeTransaction;

  const TransactionItem({
    super.key,
    required this.tr,
    required this.removeTransaction,
  });

  @override
  State<TransactionItem> createState() => TransactionItemState();
}

class TransactionItemState extends State<TransactionItem> {
  List<Color> colors = [
    Colors.amber,
    Colors.teal,
    Colors.white,
    Colors.deepOrange,
    Colors.pinkAccent,
    Colors.orange,
    Colors.indigo,
    Colors.brown,
    Colors.red,
    Colors.deepPurple,
  ];

  Color _background = Colors.red;

  @override
  void initState() {
    super.initState();

    final random = Random();

    int i = random.nextInt(colors.length);

    _background = colors[i];
  }

  String truncate(String text, maxLength) {
    if (text.length < maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border(top: BorderSide(width: 5, color: _background)),
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tr.categoria,
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.tr.carteira, style: TextStyle(fontSize: 14)),
                    Text(
                      truncate(widget.tr.descricao, 20),
                      style: TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Text(
                        'R\$${widget.tr.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.tr.date),
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      truncate(widget.tr.nota, 20),
                      style: TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),

          AdaptativeDialog(
            removeTransaction: widget.removeTransaction,
            tr: widget.tr,
          ),
        ],
      ),
    );
  }
}

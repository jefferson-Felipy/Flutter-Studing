import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_editor/models/transaction.dart';

class AdaptativeBtns extends StatelessWidget {
  final void Function(Transaction) createNewTransaction;
  const AdaptativeBtns({super.key, required this.createNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                padding: EdgeInsets.all(15),
                backgroundColor: Theme.of(context).colorScheme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: FilledButton(
              onPressed: () {

                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Cadastrar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

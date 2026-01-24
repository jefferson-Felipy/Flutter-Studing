import 'package:flutter/material.dart';
import 'package:open_editor/models/transaction.dart';

class AdaptativeDialog extends StatelessWidget {
  final void Function(String) removeTransaction;
  final Transaction tr;
  const AdaptativeDialog({
    super.key,
    required this.removeTransaction,
    required this.tr,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {
        //O showDialog() precisa estar dentro de uma função_
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Deseja Deletar essa Transação?',
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: EdgeInsets.all(10),
              actions: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 200,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              size: 30,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.delete, size: 30),
                            TextButton(
                              onPressed: () {
                                removeTransaction(tr.id);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Confirmar',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      },
      icon: Icon(
        Icons.delete,
        size: 40,
        color: Theme.of(context).colorScheme.onError,
      ),
    );
  }
}

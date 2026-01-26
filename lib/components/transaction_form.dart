import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_editor/models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction) createTransaction;
  const TransactionForm({super.key, required this.createTransaction});

  @override
  State<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  final valueController = TextEditingController();
  final categoriaController = TextEditingController();
  final carteiraController = TextEditingController();
  final notaController = TextEditingController();
  final descricaoController = TextEditingController();

  bool verifyTransaction = true;
  DateTime dateSelected = DateTime.now();

  void dateTimeSelect() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2026),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((tr) {
      setState(() {
        if (tr != null) {
          dateSelected = tr;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
                              child: Text(
                                'Cadastrar Transação',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.numbers,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  controller: valueController,
                                  decoration: InputDecoration(
                                    labelText: 'Valor',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                ),
                              ),

                              Expanded(
                                child: TextField(
                                  controller: categoriaController,
                                  decoration: InputDecoration(
                                    labelText: 'Categoria',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Total:',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      '00.00',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25,
                                Icons.account_balance_wallet_rounded,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: carteiraController,
                                  decoration: InputDecoration(
                                    labelText: 'Carteira',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25,
                                Icons.calendar_month_outlined,
                              ),

                              SizedBox(width: 10),

                              Text(
                                DateFormat('dd/MM/yyyy').format(dateSelected),
                              ),

                              TextButton(
                                onPressed: () => dateTimeSelect(),
                                child: Text(
                                  'Selecionar uma data',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25,
                                Icons.person,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: descricaoController,
                                  decoration: InputDecoration(
                                    labelText: 'Nota (Opcional)',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                size: 25,
                                Icons.description_outlined,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: notaController,
                                  decoration: InputDecoration(
                                    labelText: 'Notas (Opcional)',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Verificado'),
                                Switch(
                                  activeThumbColor: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  inactiveThumbColor: Theme.of(
                                    context,
                                  ).colorScheme.onError,
                                  value: verifyTransaction,
                                  onChanged: (value) {
                                    setState(() {
                                      verifyTransaction = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          Divider(),
                        ],
                      ),

                      Container(
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
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onError,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
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
                                  widget.createTransaction(
                                    Transaction(
                                      id: Random().nextDouble().toString(),
                                      value: double.parse(valueController.text),
                                      categoria: categoriaController.text,
                                      carteira: carteiraController.text,
                                      date: dateSelected,
                                      descricao: descricaoController.text,
                                      nota: notaController.text,
                                      verifyTransaction: verifyTransaction,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

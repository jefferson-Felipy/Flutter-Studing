import 'package:flutter/material.dart';
import 'package:open_editor/components/transaction_chart.dart';
import 'package:open_editor/components/transaction_list.dart';
import 'package:open_editor/components/transaction_total.dart';
import 'package:open_editor/models/transaction.dart';

void main() {
  runApp(const HomePageApp());
}

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(137, 48, 47, 47),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.black87,
          onPrimary: const Color.fromARGB(31, 36, 36, 36),
          secondary: Colors.white,
          onSecondary: const Color.fromARGB(26, 177, 176, 176),
          error: Colors.red,
          onError: Colors.redAccent,
          surface: const Color.fromARGB(255, 1, 63, 57),
          onSurface: Colors.green,
        ),

        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
          size: 20,
          //opacity: 0.2,
          weight: 1.0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amberAccent,
          iconSize: 25,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(40),
          ),
        ),
      ),
      home: const OpenEditorApp(),
    );
  }
}

class OpenEditorApp extends StatefulWidget {
  const OpenEditorApp({super.key});

  @override
  State<OpenEditorApp> createState() => OpenEditorAppState();
}

class OpenEditorAppState extends State<OpenEditorApp> {
  //Lista de transações_
  final List<Transaction> _transactions = [
    Transaction(
      id: '',
      value: 56.2,
      categoria: '',
      carteira: '',
      date: DateTime.now(),
      descricao: '',
      nota: '',
    ),
    Transaction(
      id: '',
      value: 23.2,
      categoria: '',
      carteira: '',
      date: DateTime.now().subtract(Duration(days: 2)),
      descricao: '',
      nota: '',
    ),
    Transaction(
      id: '',
      value: 10.2,
      categoria: '',
      carteira: '',
      date: DateTime.now().subtract(Duration(days: 3)),
      descricao: '',
      nota: '',
    ),
    Transaction(
      id: '',
      value: 43.2,
      categoria: '',
      carteira: '',
      date: DateTime.now().subtract(Duration(days: 1)),
      descricao: '',
      nota: '',
    ),
    Transaction(
      id: '',
      value: 95.2,
      categoria: '',
      carteira: '',
      date: DateTime.now().subtract(Duration(days: 4)),
      descricao: '',
      nota: '',
    ),
  ];

  //Lista de transações da mesma semana filtrada usando o where()_

  @override
  Widget build(BuildContext context) {
    final List<Transaction> _recentTransactions = _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Text('Transações Pessoais'),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, size: Theme.of(context).iconTheme.size),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.account_balance_wallet_rounded,
            size: Theme.of(context).iconTheme.size,
          ),
        ),
      ],
    );

    final heightWidgetPage =
        mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom -
        appBar.preferredSize.height;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Chart_
            SizedBox(
              height: heightWidgetPage * 0.25,
              child: TransactionChart(recentTransactions: _recentTransactions),
            ),
            //Total das transações
            SizedBox(
              height: heightWidgetPage * 0.15,
              child: TransactionTotal(),
            ),
            //Lista de Transações
            SizedBox(height: heightWidgetPage * 0.6, child: TransactionList()),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

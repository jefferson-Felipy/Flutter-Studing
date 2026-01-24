import 'package:flutter/material.dart';
import 'package:open_editor/components/transaction_chart.dart';
import 'package:open_editor/components/transaction_form.dart';
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
          onPrimary: const Color.fromARGB(31, 156, 156, 156),
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
      id: '1',
      value: 56.2,
      categoria: 'Besteiras',
      carteira: 'Carteira',
      date: DateTime.now().subtract(Duration(days: 2)),
      descricao: 'Sorvete a noite',
      nota: 'Comprei sorvete ',
    ),
    Transaction(
      id: '2',
      value: 125.23,
      categoria: 'Carro',
      carteira: 'Cartao',
      date: DateTime.now().subtract(Duration(days: 1)),
      descricao: 'Carro de formula 1',
      nota: 'Comprei um carro',
    ),
    Transaction(
      id: '3',
      value: 22.3,
      categoria: 'Salgadinho',
      carteira: 'Carteira',
      date: DateTime.now(),
      descricao: 'Comprei salgadinhp',
      nota: 'Salgadinho',
    ),
  ];

  //Lista de transações da mesma semana filtrada usando o where()_
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void sheetModalBottom() {
    showModalBottomSheet(
      elevation: 6,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionForm();
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SizedBox(
              height: heightWidgetPage * 0.6,
              child: TransactionList(
                transactions: _recentTransactions,
                removeTransaction: _removeTransaction,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: FloatingActionButton(
        onPressed: () => sheetModalBottom(),
        child: Icon(Icons.add, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

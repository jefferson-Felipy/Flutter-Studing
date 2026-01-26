import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:open_editor/components/transaction_chart.dart';
import 'package:open_editor/components/transaction_form.dart';
import 'package:open_editor/components/transaction_list.dart';
import 'package:open_editor/components/transaction_total.dart';
import 'package:open_editor/models/transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);
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
  final List<Transaction> _transactions = [];

  //Lista de transações da mesma semana filtrada usando o where()_
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //Criando novas transações_
  void _createNewTransaction(Transaction tr) {
    setState(() {
      _transactions.add(
        Transaction(
          id: tr.id,
          value: tr.value,
          categoria: tr.categoria,
          carteira: tr.carteira,
          date: tr.date,
          descricao: tr.descricao,
          nota: tr.nota,
          verifyTransaction: tr.verifyTransaction,
        ),
      );
    });
  }

  //removendo transações_
  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  //Modal inferior para o formulário_
  void sheetModalBottom() {
    showModalBottomSheet(
      elevation: 6,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionForm(createTransaction: _createNewTransaction);
      },
    );
  }

  //verifica se o chart esta ativo_
  bool isChart = true;
  //OBS: Toda propriedade que sofrerá mudança de estado ao decorrer da aplicação,
  //deve ficar fora do método build();
  //O método build() não guarda estado;

  //Calcula a soma das transações_
  double sumTransactions() {
    return _recentTransactions.fold(
      0.0,
      (initValue, tr) => initValue + tr.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    //verifica se a tela esta na orientação paisagem_
    final bool windowOrientationLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final AppBar appBar = AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Text('Transações Pessoais'),
      ),
      actions: [
        if (windowOrientationLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                isChart = !isChart;
              });
            },
            icon: Icon(isChart ? Icons.pie_chart : Icons.list_alt_outlined),
          ),
        IconButton(
          onPressed: () => sheetModalBottom(),
          icon: Icon(Icons.add, size: Theme.of(context).iconTheme.size),
        ),
        if (!windowOrientationLandscape)
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
            // if (windowOrientationLandscape)
            //   Container(
            //     padding: EdgeInsets.all(heightWidgetPage * 0.05),
            //     height: heightWidgetPage * 0.15,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Exibir Gráfico',
            //           style: TextStyle(
            //             color: Theme.of(context).colorScheme.primary,
            //           ),
            //         ),
            //         SizedBox(width: 10),
            //         Switch.adaptive(
            //           activeThumbColor: Colors.amberAccent,
            //           inactiveThumbColor: Colors.blueGrey,
            //           value: isChart,
            //           onChanged: (value) {
            //             setState(() {
            //               isChart = value;
            //             });
            //           },
            //         ),
            //       ],
            //     ),
            //   ),

            //Chart_
            if (isChart || !windowOrientationLandscape)
              SizedBox(
                height:
                    heightWidgetPage *
                    (windowOrientationLandscape ? 0.95 : 0.25),
                child: TransactionChart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            //Total das transações
            if (!isChart || !windowOrientationLandscape)
              SizedBox(
                height:
                    heightWidgetPage * (windowOrientationLandscape ? 0.2 : 0.1),
                child: TransactionTotal(
                  totalSumTransactions: sumTransactions(),
                ),
              ),
            //Lista de Transações
            if (!isChart || !windowOrientationLandscape)
              SizedBox(
                height:
                    heightWidgetPage *
                    (windowOrientationLandscape ? 0.8 : 0.65),
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
      floatingActionButtonLocation: windowOrientationLandscape && isChart
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}

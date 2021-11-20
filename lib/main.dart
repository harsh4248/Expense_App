import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transactions_list.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import './models/transactions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Monthly Expense',
    home: MyHomePage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.amber,
      fontFamily: 'Quicksand',
      textTheme: ThemeData
          .light()
          .textTheme
          .copyWith(
        headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18),
        button: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
    ),
  ));
}

//Stateless widget should contain the variable with final keyword
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _showChart = false;
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  List<Transaction> _userTransaction = [
    //Transaction(id: '1', title: 'Shoes', amount: 199.90, date: DateTime.now()),
    //Transaction(id: '2', title: 'Shirt', amount: 399.90, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selectedDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _delTransactions(int index) {
    setState(() {
      // _userTransaction.remove(index);
      _userTransaction.removeAt(index);
    });
    print(_userTransaction);
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      //backgroundColor: Theme.of(context).appBarTheme,
      title: Text('Expense App'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //print('Button clicked');
              _startAddNewTransaction(context);
            }),
      ],
    );
    final transactionListContainer = Container(
        height: (MediaQuery
            .of(context)
            .size
            .height -
            appBar.preferredSize.height -
            MediaQuery
                .of(context)
                .padding
                .top) *
            0.7,
        child: TransactionList(_userTransaction, _delTransactions));
    final chartContainer = Container(
        height: (MediaQuery
            .of(context)
            .size
            .height -
            appBar.preferredSize.height -
            MediaQuery
                .of(context)
                .padding
                .top) *
            0.7,
        child: Chart(_userTransaction));
    final isLandscapedMode = MediaQuery
        .of(context)
        .orientation == Orientation.landscape;
    if(!isLandscapedMode)
      _showChart = false;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Column(children: List.generate(transactions.length, (index) {return Card(child: Text(transactions[index].title),);}),)
            if(isLandscapedMode)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Show Chart'),
                Switch(value: _showChart, onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },),
              ],),
            if(!isLandscapedMode)
              Container(
                  height: (MediaQuery
                      .of(context)
                      .size
                      .height -
                      appBar.preferredSize.height -
                      MediaQuery
                          .of(context)
                          .padding
                          .top) *
                      0.3,
                  child: Chart(_userTransaction)),
            _showChart ? chartContainer : transactionListContainer


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:expense_app/models/transactions.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);



  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay).substring(0,1), 'amount': totalSum};
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue+element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues[0]);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        // child: Row(
        //   children: List.generate(7, (index) {
        //     return Container(
        //       padding: EdgeInsets.all(10.0),
        //       child: Column(
        //         children: [
        //           Text('\$'),
        //           Text('${groupedTransactionValues[index].values.last}'),
        //           Text('${groupedTransactionValues[index].values.first}')
        //         ],
        //       ),
        //     );
        //   }),
        // ));
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(children: groupedTransactionValues.map((index){
          //return Text('${index['day']} : ${index['amount']}');
          return Expanded(child: BarChart(index['day'], index['amount'], maxSpending == 0.0 ? 0.0 :(index['amount'] as double)/maxSpending));
        }).toList(),),
      ),
    );
  }
}

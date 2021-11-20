import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _delTransaction;

  TransactionList(this.transactions, this._delTransaction);

//instead of singlechildscrollview in main body we can wrap this column in container with specific height and
  //because scrollview needs height and we can use use listview.builder() method because it renders only the things which are
  //viewable
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, contraints) {
            return Column(
              children: [
                Text('No Expense is added yet',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: contraints.maxHeight * 0.7,
                  child: Image.asset('assets/images/waiting.png'),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return false
                  ? Card(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            )),
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactions[index].title,
                                // style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 16.0,
                                //     color: Colors.black),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                DateFormat('yyyy/MM/dd')
                                    .format(transactions[index].date),
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          // foregroundColor: Theme.of(context).primaryColor,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                // style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 20.0,
                                //     color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${transactions[index].title}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: MediaQuery.of(context).size.width > 420
                            ? TextButton.icon(
                                onPressed: () {
                                  _delTransaction(index);
                                },
                                icon: Icon(Icons.delete),
                                label: Text('Delete'))
                            : IconButton(
                                onPressed: () {
                                  _delTransaction(index);
                                },
                                icon: Icon(Icons.delete),
                              ),
                      ),
                    );
            },
            itemCount: transactions.length,
          );
  }
}

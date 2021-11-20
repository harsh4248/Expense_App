import 'dart:io';
import 'package:expense_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function fun;

  NewTransaction(this.fun);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null)
      return;
    //to use the property fro main class
    widget.fun(enteredTitle, enteredAmount, _selectDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else {
        setState(() {
          _selectDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                //onchange it accept the string value
                //onChanged: (value) {titleInput = value; },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                //onChanged: (value) {amountInput = value;},
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectDate == null
                            ? "No date chosen"
                            : 'Picked Date: ${DateFormat.yMd().format(_selectDate)}')),
                    AdaptiveFlatButton("Choose Date", _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                // onPressed: () {
                //   //transactions.add(Transaction(id: '1', title: "titleInput", amount: amount, date: date))
                //   //print(titleController.text);
                //   fun(titleController.text,double.parse(amountController.text));
                // },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: _submitData,
                child: Text(
                  'Add Transactions',
                  style: Theme.of(context).textTheme.button,
                ),
                // style: ButtonStyle(alignment: Alignment.co),
              )
            ],
          ),
        ),
      ),
    );
  }
}

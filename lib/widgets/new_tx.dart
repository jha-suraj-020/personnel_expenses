import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtx extends StatefulWidget {
  final Function addTx;

  Newtx(this.addTx);

  @override
  _NewtxState createState() => _NewtxState();
}

class _NewtxState extends State<Newtx> {
  final titleInp = TextEditingController();

  final amountInp = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (amountInp.text.isEmpty) {
      return;
    }
    final enteredTitle = titleInp.text;
    final enteredAmount = double.parse(amountInp.text);
   
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleInp,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInp,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    )),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

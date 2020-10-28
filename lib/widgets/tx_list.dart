import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modals/transaction.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deltx;

  TxList(this.transactions, this.deltx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                          child: Text('Rs.${transactions[index].amount}')),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () => deltx(transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deltx(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

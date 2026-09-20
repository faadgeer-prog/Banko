import 'package:flutter/material.dart';
import '../models/banko_state.dart';
import '../models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final banko = BankoState.instance;

  String dateText(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المعاملات السابقة'),
          centerTitle: true,
          backgroundColor: const Color(0xFFD71920),
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: banko.transactions.length,
          itemBuilder: (context, index) {
            final transaction = banko.transactions[index];
            final credit = transaction.type == TransactionType.credit;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      credit ? Colors.green.shade100 : Colors.red.shade100,
                  child: Icon(
                    credit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: credit ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(
                  transaction.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${transaction.subtitle}\n${dateText(transaction.date)}',
                ),
                isThreeLine: true,
                trailing: Text(
                  '${credit ? '+' : '-'}${transaction.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: credit ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

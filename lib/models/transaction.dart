class BankoTransaction {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final TransactionType type;

  const BankoTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
  });

  bool get isCredit => type == TransactionType.credit;
}

enum TransactionType {
  credit,
  debit,
}

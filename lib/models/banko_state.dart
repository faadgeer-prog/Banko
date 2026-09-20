import 'transaction.dart';

class BankoState {
  static final BankoState instance = BankoState._internal();

  BankoState._internal();

  double balance = 20237;

  final List<BankoTransaction> transactions = [
    BankoTransaction(
      id: 'opening',
      title: 'الرصيد الافتتاحي',
      subtitle: 'حساب Banko التجريبي',
      amount: 20237,
      date: DateTime(2026, 9, 20, 10, 0),
      type: TransactionType.credit,
    ),
  ];

  bool transfer({
    required String account,
    required String name,
    required double amount,
    String reason = '',
  }) {
    if (amount <= 0 || amount > balance) {
      return false;
    }

    balance -= amount;

    transactions.insert(
      0,
      BankoTransaction(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: 'تحويل إلى $name',
        subtitle: reason.isEmpty
            ? 'حساب المستفيد: $account'
            : '$reason • حساب: $account',
        amount: amount,
        date: DateTime.now(),
        type: TransactionType.debit,
      ),
    );

    return true;
  }

  void addMoney(
    double amount, {
    String reason = 'إضافة رصيد تجريبي',
  }) {
    if (amount <= 0) return;

    balance += amount;

    transactions.insert(
      0,
      BankoTransaction(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: 'إضافة رصيد',
        subtitle: reason,
        amount: amount,
        date: DateTime.now(),
        type: TransactionType.credit,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/banko_state.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final accountController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final reasonController = TextEditingController();

  final banko = BankoState.instance;
  bool loading = false;

  @override
  void dispose() {
    accountController.dispose();
    nameController.dispose();
    amountController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  Future<void> confirmTransfer() async {
    final account = accountController.text.trim();
    final name = nameController.text.trim();
    final amount = double.tryParse(amountController.text.trim()) ?? 0;
    final reason = reasonController.text.trim();

    if (account.isEmpty || name.isEmpty || amount <= 0) {
      _message('اكمل بيانات التحويل بصورة صحيحة');
      return;
    }

    if (amount > banko.balance) {
      _message('الرصيد التجريبي غير كاف');
      return;
    }

    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 500));

    final success = banko.transfer(
      account: account,
      name: name,
      amount: amount,
      reason: reason,
    );

    if (!mounted) return;
    setState(() => loading = false);

    if (!success) {
      _message('تعذر تنفيذ التحويل');
      return;
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('تم التحويل بنجاح'),
        content: Text(
          'تم تحويل ${amount.toStringAsFixed(0)} جنيه إلى $name',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تم'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  InputDecoration decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD71920),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'تحويلات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([]),
                builder: (_, __) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD71920), Color(0xFFB51218)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'الرصيد المتاح للتحويل',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${banko.balance.toStringAsFixed(0)} جنيه',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: decoration(
                  'رقم حساب المستفيد',
                  Icons.account_balance_outlined,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: nameController,
                decoration: decoration(
                  'اسم المستفيد',
                  Icons.person_outline,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: decoration(
                  'المبلغ',
                  Icons.payments_outlined,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: reasonController,
                maxLines: 2,
                decoration: decoration(
                  'سبب التحويل (اختياري)',
                  Icons.notes_outlined,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: loading ? null : confirmTransfer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD71920),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          'تأكيد التحويل',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

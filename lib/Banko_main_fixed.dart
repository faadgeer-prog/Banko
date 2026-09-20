import 'package:flutter/material.dart';

void main() {
  runApp(const BankoApp());
}

const Color red = Color(0xFFD71920);
const Color darkRed = Color(0xFF9F0F15);
const Color deepRed = Color(0xFF76090D);
const Color gold = Color(0xFFC7A21A);
const Color background = Color(0xFFF2F2F4);
const Color textDark = Color(0xFF202124);
const Color textGrey = Color(0xFF777777);

class BankoApp extends StatelessWidget {
  const BankoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banko',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: red,
          primary: red,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: red,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Color(0xFFE1E1E1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: red, width: 1.5),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class BankoTransaction {
  final String title;
  final String subtitle;
  final double amount;
  final bool credit;
  final DateTime date;

  BankoTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.credit,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

class BankoData extends ChangeNotifier {
  static final BankoData instance = BankoData._();

  BankoData._();

  double balance = 20237;

  final List<BankoTransaction> transactions = [
    BankoTransaction(
      title: 'الرصيد الافتتاحي',
      subtitle: 'حساب Banko التجريبي',
      amount: 20237,
      credit: true,
      date: DateTime(2026, 9, 20, 10),
    ),
  ];

  void addMoney(double amount) {
    if (amount <= 0) return;
    balance += amount;
    transactions.insert(
      0,
      BankoTransaction(
        title: 'إضافة رصيد',
        subtitle: 'عملية تجريبية',
        amount: amount,
        credit: true,
      ),
    );
    notifyListeners();
  }

  bool transfer(double amount, String name, String account, String reason) {
    if (amount <= 0 || amount > balance) return false;
    balance -= amount;
    transactions.insert(
      0,
      BankoTransaction(
        title: 'تحويل إلى $name',
        subtitle: reason.isEmpty ? 'الحساب: $account' : reason,
        amount: amount,
        credit: false,
      ),
    );
    notifyListeners();
    return true;
  }

  bool withdraw(double amount) {
    if (amount <= 0 || amount > balance) return false;
    balance -= amount;
    transactions.insert(
      0,
      BankoTransaction(
        title: 'سحب نقدي',
        subtitle: 'عملية تجريبية',
        amount: amount,
        credit: false,
      ),
    );
    notifyListeners();
    return true;
  }

  bool payBill(double amount, String biller) {
    if (amount <= 0 || amount > balance) return false;
    balance -= amount;
    transactions.insert(
      0,
      BankoTransaction(
        title: 'دفع فاتورة',
        subtitle: biller,
        amount: amount,
        credit: false,
      ),
    );
    notifyListeners();
    return true;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  final account = TextEditingController(text: '7619569');
  final password = TextEditingController();

  @override
  void dispose() {
    account.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 285,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF242A),
                      red,
                      darkRed,
                      deepRed,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(38),
                    bottomRight: Radius.circular(38),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -70,
                      left: -50,
                      child: _circleDecoration(180),
                    ),
                    Positioned(
                      bottom: -80,
                      right: -40,
                      child: _circleDecoration(190),
                    ),
                    const Center(
                      child: BankoLogo(large: true, light: true),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 25, 24, 20),
                  child: Column(
                    children: [
                      const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'مرحباً بك في Banko',
                        style: TextStyle(color: textGrey, fontSize: 14),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: account,
                        keyboardType: TextInputType.number,
                        decoration: input(
                          'رقم الحساب أو رقم العميل',
                          Icons.person_outline,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: password,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          hintText: 'ادخل كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => obscure = !obscure),
                            icon: Icon(
                              obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          style: redButton(),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'تسجيل جديد',
                              style: TextStyle(color: red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(color: red),
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.qr_code_2, color: red),
                        label: const Text(
                          'شارك رمز',
                          style: TextStyle(color: red),
                        ),
                      ),
                    ],
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = BankoData.instance;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const BankoLogo(light: true),
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => push(context, const SettingsScreen()),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        body: AnimatedBuilder(
          animation: data,
          builder: (_, __) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(13, 16, 13, 25),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'مساء الخير، محمد 👋',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'إليك ملخص حسابك اليوم',
                      style: TextStyle(fontSize: 13, color: textGrey),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BalanceCard(balance: data.balance),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الخدمات المصرفية',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 14,
                    childAspectRatio: .72,
                    children: [
                      Service('تحويلات', Icons.swap_horiz_rounded,
                          () => push(context, const TransferScreen())),
                      Service('دفع فواتير', Icons.receipt_long_rounded,
                          () => push(context, const BillsScreen())),
                      Service('تفاصيل الحساب',
                          Icons.account_balance_wallet_outlined,
                          () => push(context, const AccountScreen())),
                      Service('سحب', Icons.atm_rounded,
                          () => push(context, const WithdrawScreen())),
                      Service('Banko PAY', Icons.qr_code_2_rounded,
                          () => push(context, const QRScreen())),
                      Service('إضافة رصيد', Icons.add_card_rounded,
                          () => push(context, const AddMoneyScreen())),
                      Service('إدارة البطاقات', Icons.credit_card_rounded,
                          () => push(context, const CardsScreen())),
                      Service('المعاملات السابقة', Icons.history_rounded,
                          () => push(context, const TransactionsScreen())),
                      Service('المستفيدون', Icons.person_add_alt_1_rounded,
                          () => push(context, const BeneficiariesScreen())),
                      Service('الضبط', Icons.settings_rounded,
                          () => push(context, const SettingsScreen())),
                      Service('أوامر الدفع', Icons.fact_check_outlined,
                          () => push(context, const GenericScreen('أوامر الدفع'))),
                      Service('طلبات', Icons.edit_note_rounded,
                          () => push(context, const GenericScreen('الطلبات'))),
                      Service('التجارة الإلكترونية', Icons.shopping_cart_outlined,
                          () => push(context, const GenericScreen('التجارة الإلكترونية'))),
                      Service('العملات الأجنبية', Icons.currency_exchange_rounded,
                          () => push(context, const GenericScreen('خدمات العملات الأجنبية'))),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final double balance;

  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(21, 18, 21, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [red, darkRed],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x45000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 39,
                height: 39,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const Spacer(),
              const Text(
                'حساب توفير',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 17),
          const Text(
            'الرصيد المتاح',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 3),
          Text(
            '${balance.toStringAsFixed(0)} جنيه',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            '**** 7619569',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class Service extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const Service(this.title, this.icon, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE52D34), red, darkRed],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 27),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final account = TextEditingController();
  final name = TextEditingController();
  final amount = TextEditingController();
  final reason = TextEditingController();

  @override
  void dispose() {
    account.dispose();
    name.dispose();
    amount.dispose();
    reason.dispose();
    super.dispose();
  }

  void submit() {
    final value = double.tryParse(amount.text) ?? 0;

    if (name.text.trim().isEmpty || account.text.trim().isEmpty) {
      snack(context, 'أكمل بيانات المستفيد');
      return;
    }

    final ok = BankoData.instance.transfer(
      value,
      name.text.trim(),
      account.text.trim(),
      reason.text.trim(),
    );

    if (!ok) {
      snack(
        context,
        value > BankoData.instance.balance
            ? 'الرصيد غير كاف'
            : 'أدخل مبلغ صحيح',
      );
      return;
    }

    snack(context, 'تم التحويل بنجاح');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'تحويلات',
      children: [
        sectionTitle('بيانات المستفيد'),
        field(account, 'رقم حساب المستفيد', Icons.account_balance_outlined),
        field(name, 'اسم المستفيد', Icons.person_outline),
        sectionTitle('تفاصيل التحويل'),
        field(amount, 'المبلغ', Icons.payments_outlined, number: true),
        field(reason, 'سبب التحويل (اختياري)', Icons.notes_outlined),
        button('تأكيد التحويل', submit),
      ],
    );
  }
}

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final amount = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'إضافة رصيد',
      children: [
        sectionTitle('إضافة رصيد تجريبي'),
        field(amount, 'المبلغ', Icons.add_card_rounded, number: true),
        button('إضافة الرصيد', () {
          final value = double.tryParse(amount.text) ?? 0;
          if (value <= 0) {
            snack(context, 'أدخل مبلغ صحيح');
            return;
          }
          BankoData.instance.addMoney(value);
          snack(context, 'تمت إضافة الرصيد');
          Navigator.pop(context);
        }),
      ],
    );
  }
}

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final amount = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'السحب',
      children: [
        sectionTitle('السحب النقدي'),
        field(amount, 'المبلغ', Icons.atm_rounded, number: true),
        button('تأكيد السحب', () {
          final value = double.tryParse(amount.text) ?? 0;
          if (!BankoData.instance.withdraw(value)) {
            snack(context, 'المبلغ غير صحيح أو الرصيد غير كاف');
            return;
          }
          snack(context, 'تم السحب بنجاح');
          Navigator.pop(context);
        }),
      ],
    );
  }
}

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final amount = TextEditingController();
  String biller = 'كهرباء';

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'دفع الفواتير',
      children: [
        sectionTitle('نوع الفاتورة'),
        DropdownButtonFormField<String>(
          initialValue: biller,
          decoration: input('نوع الفاتورة', Icons.receipt_long_rounded),
          items: const ['كهرباء', 'مياه', 'اتصالات', 'إنترنت']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => biller = value);
            }
          },
        ),
        sectionTitle('قيمة الفاتورة'),
        field(amount, 'المبلغ', Icons.payments_outlined, number: true),
        button('دفع الفاتورة', () {
          final value = double.tryParse(amount.text) ?? 0;
          if (!BankoData.instance.payBill(value, biller)) {
            snack(context, 'المبلغ غير صحيح أو الرصيد غير كاف');
            return;
          }
          snack(context, 'تم دفع الفاتورة');
          Navigator.pop(context);
        }),
      ],
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المعاملات السابقة')),
        body: AnimatedBuilder(
          animation: BankoData.instance,
          builder: (_, __) {
            final transactions = BankoData.instance.transactions;

            if (transactions.isEmpty) {
              return const Center(child: Text('لا توجد معاملات'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(13),
              itemCount: transactions.length,
              itemBuilder: (_, index) {
                final transaction = transactions[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: transaction.credit
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      child: Icon(
                        transaction.credit
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: transaction.credit ? Colors.green : red,
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(transaction.subtitle),
                    trailing: Text(
                      '${transaction.credit ? '+' : '-'}${transaction.amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: transaction.credit ? Colors.green : red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'تفاصيل الحساب',
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [red, darkRed]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 55,
              ),
              SizedBox(height: 12),
              Text(
                'حساب توفير',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'حساب Banko التجريبي',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        infoCard(
          'رقم الحساب',
          '1003076195690001',
          Icons.account_balance_outlined,
        ),
        infoCard(
          'IBAN',
          'SD4204076195690001',
          Icons.qr_code_2_rounded,
        ),
        infoCard(
          'الرصيد الحالي',
          '${BankoData.instance.balance.toStringAsFixed(0)} جنيه',
          Icons.payments_outlined,
        ),
        button(
          'عرض المعاملات',
          () => push(context, const TransactionsScreen()),
        ),
      ],
    );
  }
}

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'إدارة البطاقات',
      children: [
        Container(
          height: 205,
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF171717), Color(0xFF4A090B), red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(21),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 12,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'BANKO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.contactless_rounded,
                    color: Colors.white70,
                    size: 27,
                  ),
                ],
              ),
              Spacer(),
              Text(
                '****  ****  ****  2026',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 9),
              Text(
                'BANKO DEMO CARD',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        button(
          'إضافة بطاقة تجريبية',
          () => snack(context, 'تمت إضافة بطاقة تجريبية'),
        ),
      ],
    );
  }
}

class BeneficiariesScreen extends StatelessWidget {
  const BeneficiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'المستفيدون',
      children: [
        beneficiary('أحمد محمد', '1003076195690001'),
        beneficiary('سارة علي', '1003076195690002'),
        beneficiary('محمد أحمد', '1003076195690003'),
        button(
          'إضافة مستفيد',
          () => snack(context, 'ميزة تجريبية'),
        ),
      ],
    );
  }
}

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'Banko PAY',
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.qr_code_2_rounded,
            size: 210,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'امسح الرمز للدفع التجريبي',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'استخدم هذا الرمز لإتمام عملية دفع تجريبية',
          style: TextStyle(color: textGrey),
          textAlign: TextAlign.center,
        ),
        button(
          'إنشاء رمز جديد',
          () => snack(context, 'تم إنشاء رمز تجريبي جديد'),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: 'الملف الشخصي',
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundColor: red,
          child: Icon(Icons.person, size: 53, color: Colors.white),
        ),
        const SizedBox(height: 4),
        const Text(
          'محمد',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const Text(
          'رقم العميل: 7619569',
          style: TextStyle(color: textGrey),
        ),
        infoCard(
          'نوع الحساب',
          'حساب توفير',
          Icons.account_balance_outlined,
        ),
        infoCard(
          'رقم الهاتف',
          '+249 *********',
          Icons.phone_outlined,
        ),
        button(
          'تعديل البيانات',
          () => snack(context, 'ميزة تجريبية'),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الإعدادات')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            settingsTile(
              icon: Icons.person_outline_rounded,
              title: 'الملف الشخصي',
              subtitle: 'بيانات الحساب الشخصية',
              onTap: () => push(context, const ProfileScreen()),
            ),
            settingsTile(
              icon: Icons.security_rounded,
              title: 'الأمان والخصوصية',
              subtitle: 'كلمة المرور والحماية',
              onTap: () {},
            ),
            settingsTile(
              icon: Icons.notifications_none_rounded,
              title: 'الإشعارات',
              subtitle: 'إدارة إشعارات التطبيق',
              onTap: () {},
            ),
            settingsTile(
              icon: Icons.language_rounded,
              title: 'اللغة',
              subtitle: 'العربية',
              onTap: () {},
            ),
            const Divider(height: 25, indent: 18, endIndent: 18),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: red.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.logout_rounded, color: red),
              ),
              title: const Text(
                'تسجيل الخروج',
                style: TextStyle(color: red, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GenericScreen extends StatelessWidget {
  final String title;

  const GenericScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: title,
      children: [
        const SizedBox(height: 35),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: red.withValues(alpha: .08),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.construction_rounded,
            size: 55,
            color: red,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'هذه الخدمة قيد التطوير',
          style: TextStyle(color: textGrey),
        ),
      ],
    );
  }
}

class FormPage extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FormPage({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...children.map(
                (widget) => Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: widget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankoLogo extends StatelessWidget {
  final bool large;
  final bool light;

  const BankoLogo({
    super.key,
    this.large = false,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'بنكو',
          style: TextStyle(
            color: light ? Colors.white : red,
            fontSize: large ? 49 : 29,
            fontWeight: FontWeight.w900,
            height: .88,
          ),
        ),
        Text(
          'banko',
          style: TextStyle(
            color: gold,
            fontSize: large ? 31 : 19,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            height: .95,
          ),
        ),
      ],
    );
  }
}

Widget _circleDecoration(double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withValues(alpha: .04),
      border: Border.all(
        color: Colors.white.withValues(alpha: .05),
      ),
    ),
  );
}

InputDecoration input(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon, color: red),
  );
}

ButtonStyle redButton() {
  return ElevatedButton.styleFrom(
    backgroundColor: red,
    foregroundColor: Colors.white,
    elevation: 3,
    shadowColor: red.withValues(alpha: .35),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );
}

Widget field(
  TextEditingController controller,
  String hint,
  IconData icon, {
  bool number = false,
}) {
  return TextField(
    controller: controller,
    keyboardType: number
        ? const TextInputType.numberWithOptions(decimal: true)
        : TextInputType.text,
    decoration: input(hint, icon),
  );
}

Widget button(String text, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: onTap,
      style: redButton(),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget sectionTitle(String title) {
  return Align(
    alignment: Alignment.centerRight,
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
    ),
  );
}

Widget infoCard(String title, String value, IconData icon) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Color(0x10000000),
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: red.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: red),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: textGrey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget beneficiary(String name, String account) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Color(0x10000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: red,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(account),
      trailing: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 16,
      ),
    ),
  );
}

Widget settingsTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 3,
    ),
    leading: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: red.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: red),
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(subtitle),
    trailing: const Icon(
      Icons.arrow_back_ios_new_rounded,
      size: 15,
    ),
    onTap: onTap,
  );
}

void push(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}

void snack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF292929),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

void main() => runApp(const BankoApp());

class BankoApp extends StatelessWidget {
  const BankoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banko Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD71920)),
      ),
      home: const LoginScreen(),
    );
  }
}

const red = Color(0xFFD71920);
const darkRed = Color(0xFFB51218);
const gold = Color(0xFFC7A21A);

class BankoTransaction {
  final String title, subtitle;
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
    transactions.insert(0, BankoTransaction(
      title: 'إضافة رصيد',
      subtitle: 'عملية تجريبية',
      amount: amount,
      credit: true,
    ));
    notifyListeners();
  }

  bool transfer(double amount, String name, String account, String reason) {
    if (amount <= 0 || amount > balance) return false;
    balance -= amount;
    transactions.insert(0, BankoTransaction(
      title: 'تحويل إلى $name',
      subtitle: reason.isEmpty ? 'الحساب: $account' : reason,
      amount: amount,
      credit: false,
    ));
    notifyListeners();
    return true;
  }

  bool withdraw(double amount) {
    if (amount <= 0 || amount > balance) return false;
    balance -= amount;
    transactions.insert(0, BankoTransaction(
      title: 'سحب نقدي',
      subtitle: 'عملية تجريبية',
      amount: amount,
      credit: false,
    ));
    notifyListeners();
    return true;
  }

  bool payBill(double amount, String biller) {
    if (amount <= 0 || amount > balance) return false;
    balance -= amount;
    transactions.insert(0, BankoTransaction(
      title: 'دفع فاتورة',
      subtitle: biller,
      amount: amount,
      credit: false,
    ));
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
        body: Column(
          children: [
            Container(
              height: 330,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF1017), red, darkRed],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(child: BankoLogo(large: true, light: true)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    TextField(
                      controller: account,
                      keyboardType: TextInputType.number,
                      decoration: input('رقم الحساب أو رقم العميل', Icons.person_outline),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: password,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        hintText: 'ادخل كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => obscure = !obscure),
                          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        ),
                        style: redButton(),
                        child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 21)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () {}, child: const Text('تسجيل جديد')),
                        TextButton(onPressed: () {}, child: const Text('نسيت كلمة المرور؟')),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_2, color: red),
                      label: const Text('شارك رمز'),
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = BankoData.instance;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: red,
          foregroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const BankoLogo(light: true),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
        ),
        body: AnimatedBuilder(
          animation: data,
          builder: (_, __) => SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('مساء الخير، محمد', style: TextStyle(fontSize: 22)),
                ),
                const SizedBox(height: 15),
                BalanceCard(balance: data.balance),
                const SizedBox(height: 18),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: .78,
                  children: [
                    Service('تحويلات', Icons.swap_horiz, () => push(context, const TransferScreen())),
                    Service('دفع فواتير', Icons.receipt_long, () => push(context, const BillsScreen())),
                    Service('تفاصيل الحساب', Icons.person_outline, () => push(context, const AccountScreen())),
                    Service('إضافة رصيد', Icons.add_card, () => push(context, const AddMoneyScreen())),
                    Service('Banko PAY', Icons.qr_code_2, () => push(context, const QRScreen())),
                    Service('سحب', Icons.atm, () => push(context, const WithdrawScreen())),
                    Service('إدارة البطاقات', Icons.credit_card, () => push(context, const CardsScreen())),
                    Service('المعاملات السابقة', Icons.history, () => push(context, const TransactionsScreen())),
                    Service('المستفيدون', Icons.person_add_alt_1, () => push(context, const BeneficiariesScreen())),
                    Service('الضبط', Icons.settings, () => push(context, const SettingsScreen())),
                    Service('أوامر الدفع', Icons.fact_check_outlined, () => push(context, const GenericScreen('أوامر الدفع'))),
                    Service('طلبات', Icons.edit_note, () => push(context, const GenericScreen('الطلبات'))),
                    Service('التجارة الإلكترونية', Icons.shopping_cart_outlined, () => push(context, const GenericScreen('التجارة الإلكترونية'))),
                    Service('العملات الأجنبية', Icons.currency_exchange, () => push(context, const GenericScreen('خدمات العملات الأجنبية'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final double balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [red, darkRed]),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('الرصيد المتاح', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 5),
        Text('${balance.toStringAsFixed(0)} جنيه',
          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

class Service extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const Service(this.title, this.icon, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(13),
    child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFE85A5F), red]),
              borderRadius: BorderRadius.circular(13),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 5, offset: Offset(0, 3))],
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 40)),
          ),
        ),
        const SizedBox(height: 7),
        Text(title, textAlign: TextAlign.center, maxLines: 2),
      ],
    ),
  );
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
    account.dispose(); name.dispose(); amount.dispose(); reason.dispose(); super.dispose();
  }

  void submit() {
    final value = double.tryParse(amount.text) ?? 0;
    final ok = BankoData.instance.transfer(value, name.text.trim(), account.text.trim(), reason.text.trim());
    if (!ok) {
      snack(context, value > BankoData.instance.balance ? 'الرصيد غير كاف' : 'أكمل البيانات');
      return;
    }
    snack(context, 'تم التحويل بنجاح');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => FormPage(
    title: 'تحويلات',
    children: [
      field(account, 'رقم حساب المستفيد', Icons.account_balance_outlined),
      field(name, 'اسم المستفيد', Icons.person_outline),
      field(amount, 'المبلغ', Icons.payments_outlined, number: true),
      field(reason, 'سبب التحويل (اختياري)', Icons.notes_outlined),
      button('تأكيد التحويل', submit),
    ],
  );
}

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});
  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}
class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) => FormPage(
    title: 'إضافة رصيد تجريبي',
    children: [
      field(amount, 'المبلغ', Icons.add_card, number: true),
      button('إضافة الرصيد', () {
        final value = double.tryParse(amount.text) ?? 0;
        if (value <= 0) return snack(context, 'أدخل مبلغ صحيح');
        BankoData.instance.addMoney(value);
        snack(context, 'تمت إضافة الرصيد');
        Navigator.pop(context);
      }),
    ],
  );
}

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});
  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}
class _WithdrawScreenState extends State<WithdrawScreen> {
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) => FormPage(
    title: 'السحب',
    children: [
      field(amount, 'المبلغ', Icons.atm, number: true),
      button('تأكيد السحب', () {
        final value = double.tryParse(amount.text) ?? 0;
        if (!BankoData.instance.withdraw(value)) return snack(context, 'المبلغ غير صحيح أو الرصيد غير كاف');
        snack(context, 'تم السحب بنجاح');
        Navigator.pop(context);
      }),
    ],
  );
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
  Widget build(BuildContext context) => FormPage(
    title: 'دفع الفواتير',
    children: [
      DropdownButtonFormField<String>(
        initialValue: biller,
        items: ['كهرباء', 'مياه', 'اتصالات', 'إنترنت']
            .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => setState(() => biller = v!),
        decoration: input('نوع الفاتورة', Icons.receipt_long),
      ),
      field(amount, 'المبلغ', Icons.payments_outlined, number: true),
      button('دفع الفاتورة', () {
        final value = double.tryParse(amount.text) ?? 0;
        if (!BankoData.instance.payBill(value, biller)) return snack(context, 'المبلغ غير صحيح أو الرصيد غير كاف');
        snack(context, 'تم دفع الفاتورة');
        Navigator.pop(context);
      }),
    ],
  );
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('المعاملات السابقة'), backgroundColor: red, foregroundColor: Colors.white),
      body: AnimatedBuilder(
        animation: BankoData.instance,
        builder: (_, __) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: BankoData.instance.transactions.length,
          itemBuilder: (_, i) {
            final t = BankoData.instance.transactions[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: t.credit ? Colors.green.shade100 : Colors.red.shade100,
                  child: Icon(t.credit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: t.credit ? Colors.green : red),
                ),
                title: Text(t.title),
                subtitle: Text(t.subtitle),
                trailing: Text('${t.credit ? '+' : '-'}${t.amount.toStringAsFixed(0)}',
                  style: TextStyle(color: t.credit ? Colors.green : red, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) => FormPage(
    title: 'تفاصيل الحساب',
    children: [
      const Icon(Icons.account_balance_wallet, color: red, size: 65),
      const Text('حساب توفير', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      const Text('رقم الحساب: 1003076195690001'),
      const Text('IBAN: SD4204076195690001'),
      const SizedBox(height: 20),
      Text('الرصيد: ${BankoData.instance.balance.toStringAsFixed(0)} جنيه',
        style: const TextStyle(fontSize: 22, color: red, fontWeight: FontWeight.bold)),
      button('عرض المعاملات', () => push(context, const TransactionsScreen())),
    ],
  );
}

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});
  @override
  Widget build(BuildContext context) => FormPage(title: 'إدارة البطاقات', children: [
    Container(
      height: 190,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [darkRed, red]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BANKO', style: TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold)),
          Spacer(),
          Text('**** **** **** 2026', style: TextStyle(color: Colors.white, fontSize: 21)),
          Text('BANKO DEMO CARD', style: TextStyle(color: Colors.white70)),
        ],
      ),
    ),
    button('إضافة بطاقة تجريبية', () => snack(context, 'تمت إضافة بطاقة تجريبية')),
  ]);
}

class BeneficiariesScreen extends StatelessWidget {
  const BeneficiariesScreen({super.key});
  @override
  Widget build(BuildContext context) => FormPage(title: 'المستفيدون', children: [
    const ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('أحمد محمد'), subtitle: Text('1003076195690001')),
    const ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('سارة علي'), subtitle: Text('1003076195690002')),
    button('إضافة مستفيد', () => snack(context, 'ميزة تجريبية')),
  ]);
}

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});
  @override
  Widget build(BuildContext context) => FormPage(title: 'Banko PAY', children: [
    const Icon(Icons.qr_code_2, size: 190, color: Colors.black),
    const Text('امسح الرمز للدفع التجريبي', style: TextStyle(fontSize: 18)),
    button('إنشاء رمز جديد', () => snack(context, 'تم إنشاء رمز تجريبي')),
  ]);
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => FormPage(title: 'الملف الشخصي', children: [
    const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
    const Text('محمد', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const Text('7619569'),
    button('تعديل البيانات', () => snack(context, 'ميزة تجريبية')),
  ]);
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: red, foregroundColor: Colors.white),
      body: ListView(
        children: [
          ListTile(leading: const Icon(Icons.person), title: const Text('الملف الشخصي'),
            onTap: () => push(context, const ProfileScreen())),
          const ListTile(leading: Icon(Icons.security), title: Text('الأمان والخصوصية')),
          const ListTile(leading: Icon(Icons.notifications_none), title: Text('الإشعارات')),
          const ListTile(leading: Icon(Icons.language), title: Text('اللغة: العربية')),
          ListTile(
            leading: const Icon(Icons.logout, color: red),
            title: const Text('تسجيل الخروج', style: TextStyle(color: red)),
            onTap: () => Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false),
          ),
        ],
      ),
    ),
  );
}

class GenericScreen extends StatelessWidget {
  final String title;
  const GenericScreen(this.title, {super.key});
  @override
  Widget build(BuildContext context) => FormPage(
    title: title,
    children: [
      const Icon(Icons.construction_outlined, size: 70, color: red),
      Text('$title\nقيد التطوير', textAlign: TextAlign.center, style: const TextStyle(fontSize: 22)),
    ],
  );
}

class FormPage extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const FormPage({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true, backgroundColor: red, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            ...children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 14), child: w)),
          ],
        ),
      ),
    ),
  );
}

class BankoLogo extends StatelessWidget {
  final bool large, light;
  const BankoLogo({super.key, this.large = false, this.light = false});
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('بنكو', style: TextStyle(
        color: light ? Colors.white : red,
        fontSize: large ? 48 : 29,
        fontWeight: FontWeight.w900,
        height: .9,
      )),
      Text('banko', style: TextStyle(
        color: gold,
        fontSize: large ? 34 : 21,
        fontWeight: FontWeight.w900,
        height: .9,
      )),
    ],
  );
}

InputDecoration input(String hint, IconData icon) => InputDecoration(
  hintText: hint,
  prefixIcon: Icon(icon),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
);

ButtonStyle redButton() => ElevatedButton.styleFrom(
  backgroundColor: red,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
);

Widget field(TextEditingController controller, String hint, IconData icon, {bool number = false}) => Padding(
  padding: const EdgeInsets.only(bottom: 14),
  child: TextField(
    controller: controller,
    keyboardType: number ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
    decoration: input(hint, icon),
  ),
);

Widget button(String text, VoidCallback onTap) => SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton(onPressed: onTap, style: redButton(), child: Text(text, style: const TextStyle(fontSize: 19))),
);

void push(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

void snack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

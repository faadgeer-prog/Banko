
import 'package:flutter/material.dart';

void main() {
  runApp(const BankoApp());
}

class BankoApp extends StatelessWidget {
  const BankoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'banko',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD71920),
          primary: const Color(0xFFD71920),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const LoginPage(),
    );
  }
}

const red = Color(0xFFD71920);
const darkRed = Color(0xFFB51218);
const gold = Color(0xFFC7A21A);

class BankoLogo extends StatelessWidget {
  final double scale;
  const BankoLogo({super.key, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'بنكو',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42 * scale,
            fontWeight: FontWeight.w800,
            height: .85,
          ),
        ),
        Text(
          'banko',
          style: TextStyle(
            color: gold,
            fontSize: 31 * scale,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class RedHeader extends StatelessWidget {
  final bool back;
  final VoidCallback? onBack;
  const RedHeader({super.key, this.back = false, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF151B), darkRed],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const BankoLogo(scale: .72),
            if (back)
              Positioned(
                right: 18,
                bottom: 16,
                child: OutlinedButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: const Text('رجوع'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: red,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: red, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final id = TextEditingController(text: '7619569');
  final pass = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF0E14), Color(0xFFC9151B)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(26, 26, 26, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.translate, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const BankoLogo(scale: 1.15),
                      const SizedBox(height: 70),
                      _field(
                        controller: id,
                        hint: 'ادخل رقم المعرف (رقم الحساب أو 249- رقم ...)',
                        icon: Icons.person_outline,
                        keyboard: TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      _field(
                        controller: pass,
                        hint: 'ادخل كلمة المرور',
                        icon: Icons.visibility_off_outlined,
                        obscure: obscure,
                        onIcon: () => setState(() => obscure = !obscure),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red,
                            foregroundColor: Colors.white,
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                              side: const BorderSide(color: Colors.white24),
                            ),
                          ),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () {}, child: const Text('تسجيل جديد؟', style: TextStyle(color: Colors.white, fontSize: 17))),
                          TextButton(onPressed: () {}, child: const Text('لاتستطيع تسجيل الدخول؟', style: TextStyle(color: Colors.white, fontSize: 17))),
                        ],
                      ),
                      const SizedBox(height: 25),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.qr_code_2, color: Colors.white, size: 34),
                        label: const Text('شارك رمز', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 135,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomItem(Icons.public, 'بنك الخرطوم', Colors.green),
                _bottomItem(Icons.location_on, 'مواقعنا', Colors.red),
                _bottomItem(Icons.phone, 'المساعدة', Colors.lightGreen),
                _bottomItem(Icons.facebook, 'فيس بوك', Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    VoidCallback? onIcon,
    TextInputType? keyboard,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 23),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 19, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(onPressed: onIcon, icon: Icon(icon, color: Colors.grey, size: 31)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    );
  }

  Widget _bottomItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 29),
        ),
        const SizedBox(height: 7),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 15)),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('تحويلات', Icons.sync_alt),
      ('دفع فواتير', Icons.description_outlined),
      ('تفاصيل الحساب', Icons.person_outline),
      ('طلب الودائع الاستثمارية', Icons.savings_outlined),
      ('banko PAY', Icons.qr_code_2),
      ('سحب بدون بطاقة', Icons.atm),
      ('إدارة البطاقات', Icons.credit_card),
      ('المعاملات السابقة', Icons.calendar_month),
      ('إدارة المستفيدين', Icons.person_add_alt_1),
      ('الضبط', Icons.settings),
      ('أوامر دفع دائم', Icons.checklist),
      ('طلبات', Icons.edit_note),
      ('خدمات العملات الأجنبية', Icons.currency_exchange),
      ('التجارة الالكترونية', Icons.shopping_cart_outlined),
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 116,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFFF151B), darkRed]),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const BankoLogo(scale: .72),
                  Positioned(
                    right: 14,
                    child: IconButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('هذه نسخة تجريبية فقط')),
                      ),
                      icon: const Icon(Icons.notifications_none, color: Colors.white, size: 36),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    child: IconButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      ),
                      icon: const Icon(Icons.power_settings_new, color: Colors.white, size: 34),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 25),
                children: [
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'مساء الخير ', style: TextStyle(fontSize: 20)),
                        TextSpan(text: 'Fadl Mustafa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 166,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 7,
                    ),
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return _menuTile(context, item.$1, item.$2);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(BuildContext context, String title, IconData icon) {
    return InkWell(
      onTap: () {
        if (title == 'تفاصيل الحساب') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title — نسخة تجريبية')),
          );
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            height: 96,
            width: 110,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF56D72), Color(0xFFE60009)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: darkRed, width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black38, blurRadius: 5, offset: Offset(2, 4)),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 51),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(fontSize: 17, height: 1.05),
          ),
        ],
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool showBalance = true;
  int balance = 999999999;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const RedHeader(),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Expanded(
                        child: Text(
                          'تفاصيل الحساب',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 27),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(17),
                          child: Row(
                            children: [
                              Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  color: red,
                                  borderRadius: BorderRadius.circular(31),
                                ),
                                child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 35),
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Text(
                                  'حساب توفير',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 24, color: red, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () => setState(() => showBalance = !showBalance),
                                    icon: Icon(showBalance ? Icons.visibility : Icons.visibility_off),
                                  ),
                                  Text(
                                    showBalance ? _format(balance) : '••••••••',
                                    style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                  const Text('جنيه', style: TextStyle(fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        const Padding(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            children: [
                              Text('رقم الحساب  —  10030776195690001', style: TextStyle(fontSize: 17, color: Colors.brown)),
                              SizedBox(height: 6),
                              Text('IBAN — SD4204076195690001', style: TextStyle(fontSize: 17, color: Colors.brown)),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _action(Icons.qr_code_2, 'رمز الدفع السريع QR'),
                              Container(width: 1, height: 45, color: Colors.grey),
                              _action(Icons.description_outlined, 'عرض كشف الحساب'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'هذه نسخة تجريبية Offline Demo — لا تتصل بأي بنك ولا تنفذ تحويلات حقيقية',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.center,
            color: Colors.grey.shade300,
            child: const Text('© 2026 banko — Demo Account'),
          ),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ميزة تجريبية')),
        );
      },
      icon: Icon(icon, color: Colors.black87),
      label: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black87)),
    );
  }

  String _format(int value) {
    final s = value.toString();
    final parts = <String>[];
    for (int i = s.length; i > 0; i -= 3) {
      final start = (i - 3).clamp(0, s.length);
      parts.insert(0, s.substring(start, i));
    }
    return parts.join(',');
  }
}

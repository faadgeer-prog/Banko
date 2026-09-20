import 'screens/transfer_screen.dart';
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
      title: 'Banko Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD71920),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// =========================
// Splash
// =========================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD71920),
      body: Center(
        child: BankoLogo(
          light: true,
          large: true,
        ),
      ),
    );
  }
}

// =========================
// Logo
// =========================
class BankoLogo extends StatelessWidget {
  final bool light;
  final bool large;

  const BankoLogo({
    super.key,
    this.light = false,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = large ? 48.0 : 30.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'بنكو',
          style: TextStyle(
            color: light ? Colors.white : const Color(0xFFD71920),
            fontSize: size,
            fontWeight: FontWeight.w900,
            height: .9,
          ),
        ),
        Text(
          'banko',
          style: TextStyle(
            color: const Color(0xFFC7A21A),
            fontSize: size * .72,
            fontWeight: FontWeight.w900,
            height: .9,
          ),
        ),
      ],
    );
  }
}

// =========================
// Login
// =========================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final accountController = TextEditingController(text: '7619569');
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    accountController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(userName: 'محمد'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 330,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFF1017),
                      Color(0xFFD71920),
                      Color(0xFFB51218),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 18,
                      left: 20,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.translate,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const Center(
                      child: BankoLogo(
                        light: true,
                        large: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: accountController,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                          hintText: 'رقم الحساب أو رقم العميل',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          hintText: 'ادخل كلمة المرور',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() => obscure = !obscure);
                            },
                            icon: Icon(
                              obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD71920),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'تسجيل جديد',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'لاستطيع تسجيل الدخول؟',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code_2,
                          color: Color(0xFFD71920),
                          size: 32,
                        ),
                        label: const Text(
                          'شارك رمز',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
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

// =========================
// Home
// =========================
class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });

  static const services = [
    ('تحويلات', Icons.swap_horiz),
    ('دفع فواتير', Icons.receipt_long),
    ('تفاصيل الحساب', Icons.person_outline),
    ('طلب الودائع', Icons.savings_outlined),
    ('Banko PAY', Icons.qr_code_2),
    ('سحب بدون بطاقة', Icons.atm),
    ('إدارة البطاقات', Icons.credit_card),
    ('المعاملات السابقة', Icons.history),
    ('إدارة المستفيدين', Icons.person_add_alt_1),
    ('الضبط', Icons.settings),
    ('أمر دفع دائم', Icons.fact_check_outlined),
    ('طلبات', Icons.edit_note),
    ('التجارة الإلكترونية', Icons.shopping_cart_outlined),
    ('خدمات العملات الأجنبية', Icons.currency_exchange),
  ];

  void openService(BuildContext context, String title) {
    if (title == 'تفاصيل الحساب') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountDetailsScreen()),
      );
      return;
    }

    if (title == 'تحويلات') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TransferScreen(),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GenericServiceScreen(title: title),
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
          automaticallyImplyLeading: false,
          title: const BankoLogo(light: true),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, size: 30),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.menu, size: 30),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'مساء الخير، $userName',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const BalanceCard(),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 18,
                  childAspectRatio: .76,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ServiceButton(
                    title: service.$1,
                    icon: service.$2,
                    onTap: () => openService(context, service.$1),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================
// Balance
// =========================
class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD71920),
            Color(0xFFB51218),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 4),
            color: Colors.black26,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => setState(() => visible = !visible),
            color: Colors.white,
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'الرصيد المتاح',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                Text(
                  visible ? '20,237 جنيه' : '••••••••',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.white,
            size: 42,
          ),
        ],
      ),
    );
  }
}

// =========================
// Service Button
// =========================
class ServiceButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE85A5F),
                    Color(0xFFD71920),
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: const Color(0xFF9F1117),
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              height: 1.15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// Account Details
// =========================
class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: BankoAppBar(title: 'تفاصيل الحساب'),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              AccountCard(),
              SizedBox(height: 20),
              TransactionPreview(),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFD71920),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'حساب توفير',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFD71920),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'رقم الحساب: 1003076195690001',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'IBAN: SD4204076195690001',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Icon(Icons.qr_code_2, size: 30),
                  Text('QR للدفع السريع'),
                ],
              ),
              Container(
                width: 1,
                height: 45,
                color: Colors.grey.shade300,
              ),
              const Column(
                children: [
                  Icon(Icons.description_outlined, size: 30),
                  Text('عرض كشف الحساب'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionPreview extends StatelessWidget {
  const TransactionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8F5E9),
          child: Icon(
            Icons.arrow_downward,
            color: Colors.green,
          ),
        ),
        title: const Text('إضافة رصيد تجريبي'),
        subtitle: const Text('اليوم - 10:30 ص'),
        trailing: const Text(
          '+ 20,237',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =========================
// Generic Service
// =========================
class GenericServiceScreen extends StatelessWidget {
  final String title;

  const GenericServiceScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: BankoAppBar(title: title),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.construction_outlined,
                  size: 70,
                  color: Color(0xFFD71920),
                ),
                const SizedBox(height: 20),
                Text(
                  '$title\nقيد التطوير في النسخة القادمة',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================
// Settings
// =========================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const BankoAppBar(title: 'الإعدادات'),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('الملف الشخصي'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.security_outlined),
              title: const Text('الأمان والخصوصية'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications_none),
              title: const Text('الإشعارات'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('اللغة'),
              trailing: const Text('العربية'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// App Bar
// =========================
class BankoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BankoAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFD71920),
      foregroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

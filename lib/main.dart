import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Web Safety Switch: Skips heavy mobile credentials when running inside Chrome
  if (!kIsWeb) {
    await Firebase.initializeApp();
  }
  runApp(const FreshGuardApp());
}

class FreshGuardApp extends StatelessWidget {
  const FreshGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshGuard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F9D58), // Eco Green Brand Color
        ),
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

// =========================================================================
// SCREEN 1: LANGUAGE SELECTION SCREEN
// =========================================================================
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.eco_rounded,
                size: 80,
                color: Color(0xFF0F9D58),
              ),
              const SizedBox(height: 16),
              const Text(
                'FreshGuard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please select your preferred language\nالرجاء اختيار اللغة المفضلة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              // English Choice Button
              ElevatedButton(
                onPressed: () => _proceedToGateway(context, 'en'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F9D58),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'English',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Arabic Choice Button
              OutlinedButton(
                onPressed: () => _proceedToGateway(context, 'ar'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0F9D58), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'العربية',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0F9D58),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _proceedToGateway(BuildContext context, String selectedLang) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeGatewayScreen(languageCode: selectedLang),
      ),
    );
  }
}

// =========================================================================
// SCREEN 2: WELCOME / IDENTITY GATEWAY SCREEN
// =========================================================================
class WelcomeGatewayScreen extends StatelessWidget {
  final String languageCode;
  const WelcomeGatewayScreen({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final bool isEn = languageCode == 'en';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.shield_rounded,
                size: 100,
                color: Color(0xFF0F9D58),
              ),
              const SizedBox(height: 32),
              Text(
                isEn ? 'Welcome to FreshGuard' : 'مرحباً بك في فريش جارد',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isEn
                  ? 'Join our ecosystem to monitor batch metrics, organize smart household pantries, and mitigate retail food waste.'
                  : 'انضم إلى نظامنا البيئي لمراقبة معايير المخزون، وتنظيم مستودعات الأغذية المنزلية الذكية، والحد من الهدر الغذائي.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 54),

              // Existing User Route Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthFormScreen(
                        languageCode: languageCode,
                        isSignUp: false,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F9D58),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isEn ? 'Sign In to Account' : 'تسجيل الدخول إلى الحساب',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Onboarding Registration Button
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthFormScreen(
                        languageCode: languageCode,
                        isSignUp: true,
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0F9D58), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isEn ? 'Create New Account' : 'إنشاء حساب جديد',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0F9D58),
                    fontWeight: FontWeight.bold,
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

// =========================================================================
// SCREEN 3: AUTHENTICATION FORM SCREEN (SIGN IN / SIGN UP)
// =========================================================================
class AuthFormScreen extends StatefulWidget {
  final String languageCode;
  final bool isSignUp;

  const AuthFormScreen({
    super.key,
    required this.languageCode,
    required this.isSignUp,
  });

  @override
  State<AuthFormScreen> createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEn = widget.languageCode == 'en';

    final String titleText = widget.isSignUp
        ? (isEn ? 'Create Account' : 'إنشاء حساب')
        : (isEn ? 'Welcome Back' : 'مرحباً بعودتك');

    final String buttonText = widget.isSignUp
        ? (isEn ? 'Sign Up' : 'تسجيل جديد')
: (isEn ? 'Sign In' : 'تسجيل الدخول');return Scaffold(backgroundColor: Colors.white,appBar: AppBar(backgroundColor: Colors.white,elevation: 0,leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),onPressed: () => Navigator.pop(context),),),body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 24.0),child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [Text(titleText,style: const TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Color(0xFF1A1A1A),),),const SizedBox(height: 8),Text(isEn? 'Enter your details below to continue': 'أدخل بياناتك أدناه للمتابعة',style: const TextStyle(fontSize: 15, color: Colors.grey),),const SizedBox(height: 36),TextField(controller: _emailController,keyboardType: TextInputType.emailAddress,decoration: InputDecoration(labelText: isEn ? 'Email Address' : 'البريد الإلكتروني',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),prefixIcon: const Icon(Icons.email_outlined),),),const SizedBox(height: 20),TextField(controller: _passwordController,obscureText: true,decoration: InputDecoration(labelText: isEn ? 'Password' : 'كلمة المرور',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),prefixIcon: const Icon(Icons.lock_outline_rounded),),),const SizedBox(height: 32),ElevatedButton(onPressed: () {_showMockCompletion(context, '$buttonText Action Triggered');},style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F9D58),padding: const EdgeInsets.symmetric(vertical: 16),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),),child: Text(buttonText,style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,),),),const SizedBox(height: 24),Row(children: [const Expanded(child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),),Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),child: Text(isEn ? 'OR' : 'أو',style: const TextStyle(color: Colors.grey),),),const Expanded(child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),),],),const SizedBox(height: 24),OutlinedButton(onPressed: () {_showMockCompletion(context,isEn ? 'Google Account Connected' : 'تم ربط حساب جوجل',);},style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),padding: const EdgeInsets.symmetric(vertical: 16),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [const Icon(Icons.g_mobiledata_rounded,size: 34,color: Colors.redAccent,),const SizedBox(width: 4),Text(isEn ? 'Continue with Google' : 'المتابعة باستخدام جوجل',style: const TextStyle(fontSize: 16,color: Color(0xFF1A1A1A),fontWeight: FontWeight.bold,),),],),),],),),),);}void _showMockCompletion(BuildContext context, String activity) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status: $activity')));}}
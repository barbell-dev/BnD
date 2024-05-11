import './pages/home.dart';
import 'package:flutter/material.dart';
import './pages/adminlogin.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BnD App',
      theme: ThemeData(
        fontFamily: 'poppinssb',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _handleAdminLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminLoginPage()),
    );
  }

  void _handleLogin() {
    // Handle login action here
    final String phoneNumber = _phoneNumberController.text;
    final String password = _passwordController.text;

    // Perform login logic here (e.g., API call)
    print('Login with phone number: $phoneNumber and password: $password');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    // TODO: Implement login functionality
  }

  void _handleSignup() {
    // Handle signup action here
    print('Navigate to signup page');
    // TODO: Implement navigation to signup page
  }

  void _handleForgotPassword() {
    // Handle forgot password action here
    print('Navigate to forgot password page');
    // TODO: Implement navigation to forgot password page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Login',
        //   style: TextStyle(fontFamily: 'poppinssb'),
        // ),
        // backgroundColor: Theme.of(context).colorScheme.primary,

        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 255, 4),
                    Color.fromARGB(255, 36, 108, 1)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                "BnD",
                style: const TextStyle(
                  fontFamily: "poppinssb",
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 255, 4),
                ),
              ),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text(
                'Login',
                style: TextStyle(fontFamily: 'poppinssb'),
              ),
            ),
            ElevatedButton(
                onPressed: _handleAdminLogin, child: Text('Admin Login')),
            TextButton(
              onPressed: _handleForgotPassword,
              child: Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: _handleSignup,
              child: Text('Not registered? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

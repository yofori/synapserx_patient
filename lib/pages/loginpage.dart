import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synapserx_patient/widgets/homepage.dart';

import '../providers/user_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String get routeName => 'login';
  static String get routeLocation => '/$routeName';
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

bool passwordVisible = false;

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void showAlert(String alert, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(alert),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  void login(String email, String password, BuildContext context) async {
    final notifier = ref.watch(userDataProvider.notifier);
    try {
      // try signing in
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // get the name of the user
      var user = userCred.user;
      // set display name
      notifier.setFullname(user!.displayName.toString());
      showAlert("Login successful", false);
      // if succesfull leave auth screen and go to homepage
      if (context.mounted) {
        GoRouter.of(context).goNamed(HomePage.routeName);
      }
    } on FirebaseAuthException catch (e) {
      // On error
      // If user is not found
      if (e.code == 'user-not-found') {
        showAlert("No user found for the email provided.", true);
      }
      // If password is wrong
      else if (e.code == 'wrong-password') {
        showAlert("Authentication failed: Wrong password.", true);
      } else {
        showAlert(e.message.toString(), true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Colors.black, fontSize: 16.0);
    TextStyle linkStyle = const TextStyle(color: Colors.blue);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: defaultStyle,
              children: <TextSpan>[
                const TextSpan(
                    text: 'By signing in, you agree to the synapsePx '),
                TextSpan(
                    text: 'Terms & Conditions',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Terms of Service"');
                      }),
                const TextSpan(text: ' and '),
                TextSpan(
                    text: 'Privacy Policy',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Privacy Policy"');
                      }),
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const Text(
              'Sign in to synapsePx',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                  ),
                  onPressed: () {},
                  icon: Image.asset("assets/images/icons8-google-36.png"),
                  label: const Text(
                    'Google',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    color: Colors.black,
                    Icons.apple,
                    size: 36.0,
                  ),
                  label: const Text(
                    'Apple',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                const Text('Or sign in with email',
                    style: TextStyle(fontSize: 16)),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Email',
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 1,
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: _passwordTextController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 1,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    context.go('/login/forgotpassword');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  login(_emailTextController.text.trim(),
                      _passwordTextController.text.trim(), context);
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 40,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: defaultStyle,
                children: <TextSpan>[
                  const TextSpan(text: "Don't have an Account? "),
                  TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/login/register');
                        }),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

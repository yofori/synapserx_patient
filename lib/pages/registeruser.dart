import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({
    super.key,
  });
  static String get routeName => 'register';
  static String get routeLocation => routeName;

  @override
  State<RegisterUserPage> createState() => _RegisterUserState();
}

bool passwordVisible = false;

class _RegisterUserState extends State<RegisterUserPage> {
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void showAlert(String alert, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(alert),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
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
        leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: defaultStyle,
              children: <TextSpan>[
                const TextSpan(
                    text: 'By clicking Continue, you agree to the synapsePx '),
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
              'Welcome to synapsePx',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Create an account to recieve and manage your prescriptions in a safe and responsible way',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
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
                const Text('Or continue with email',
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
                controller: _firstnameTextController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'First names',
                  hintText: 'First names',
                  prefixIcon: const Icon(Icons.person_2_outlined),
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
                controller: _lastnameTextController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Last name',
                  hintText: 'Last name',
                  prefixIcon: const Icon(Icons.person_2_outlined),
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () async {
                  User? user;
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text.trim(),
                            password: _emailTextController.text.trim());

                    user = userCredential.user;
                    await user!.updateDisplayName(
                        '${_firstnameTextController.text.trim()} ${_lastnameTextController.text.trim()}');
                    await user.reload();
                    user = FirebaseAuth.instance.currentUser;
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showAlert('The password provided is too weak.', true);
                    } else if (e.code == 'email-already-in-use') {
                      showAlert(
                          'The account already exists for that email.', true);
                    }
                  } catch (e) {
                    showAlert(e.toString(), true);
                  }
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 20),
                )),
          ],
        )),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/providers.dart';
// import 'package:whatsapp_clone/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class SignUpLogIn extends ConsumerWidget {
  final Auth0? auth0;
  const SignUpLogIn({this.auth0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final pwdController = TextEditingController();
    
    late Auth0 auth0;

    @override
    void initState() {
      super.initState();
      auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    }

    return Center(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // sign in announymsly with firebase
                const Text("Sign in/Sign Up"),
                ElevatedButton(
                  onPressed: () async {
                    final credentials =
                        await auth0.webAuthentication().login();

                    setState(() {
                      _credentials = credentials;
                    });
                  },
                  child: const Text("Log in")),
                ElevatedButton(
                  child: const Text("Sign up"),
                  onPressed: () async {
                    // pop up asking for name
                    await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Sign Up"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: "Name",
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: pwdController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("OK"),
                            onPressed: () async {
                              if (nameController.text != "") {
                                try {
                                  ref
                                      .read(nameProvider)
                                      .setName(nameController.text);
                                  await ref
                                      .read(firebaseAuthProvider)
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: pwdController.text);
                                } catch (e) {}

                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Log In"),
                  onPressed: () async {
                    // pop up asking for name
                    await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Log In"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                              ),
                            ),
                            TextField(
                              autofocus: true,
                              controller: pwdController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("OK"),
                            onPressed: () async {
                              try {
                                await ref
                                    .read(firebaseAuthProvider)
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: pwdController.text);
                              } catch (e) {
                                print(e);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


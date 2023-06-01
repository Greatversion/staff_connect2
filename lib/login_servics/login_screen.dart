import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isShow = true;
  TextEditingController useridController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formFieldKey = GlobalKey<FormState>();
  // late final FirebaseAuth _auth;
  Future<void> emailSignIn() async {
    _auth
        .signInWithEmailAndPassword(
            email: useridController.text.toString(),
            password: passController.text.toString())
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Signing in ....")));
      Navigator.pushNamed(context, 'dashBoard');
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: responsive.size.height,
        color: const Color(0xFF212B66),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PlayAnimationBuilder(
                    tween:
                        Tween(begin: 50.0, end: responsive.size.height * 0.52),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) => Image(
                          image: const AssetImage('assets/5.png'),
                          height: value,
                          width: value,
                        )),
                Text(
                  'Login with Staff Connect',
                  style: GoogleFonts.aboreto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                    key: _formFieldKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: useridController,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFE9F02),
                              labelText: "User Id",
                              floatingLabelStyle: TextStyle(
                                  fontSize: 1,
                                  color: Color(0xFFFE9F02),
                                  fontWeight: FontWeight.bold),
                              labelStyle: TextStyle(
                                  color: Color(0xFF212B66),
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              prefixIconColor: Color(0xFF212B66),
                              hintText: "Eg- user.post@sconnect.in",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10,
                                    color: Color(0xFFFE9F02),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10,
                                    color: Color(0xFFFE9F02),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter a valid Email';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passController,
                          obscureText: isShow,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFFE9F02),
                              labelText: "Password",
                              floatingLabelStyle: const TextStyle(
                                  fontSize: 1,
                                  color: Color(0xFFFE9F02),
                                  fontWeight: FontWeight.bold),
                              labelStyle: const TextStyle(
                                  color: Color(0xFF212B66),
                                  fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconColor: const Color(0xFF212B66),
                              suffixIcon: InkWell(
                                onTap: () {
                                  if (isShow == true) {
                                    setState(() {
                                      isShow = false;
                                    });
                                  } else {
                                    setState(() {
                                      isShow = true;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove_red_eye_rounded),
                              ),
                              suffixIconColor: const Color(0xFF212B66),
                              hintText: "XXXXXXX",
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10,
                                    color: Color(0xFFFE9F02),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 10,
                                    color: Color(0xFFFE9F02),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter a Password';
                            } else if (value.length <= 8) {
                              return 'Please Enter a Password of more than 8 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formFieldKey.currentState!.validate()) {
                        emailSignIn();
                      }
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "forget password ?",
                      style: TextStyle(color: Color(0xFFFE9F02)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

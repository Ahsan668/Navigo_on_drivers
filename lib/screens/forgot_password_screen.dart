import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import 'login_screen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailTextEditingController = TextEditingController();

  // declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    firebaseAuth.sendPasswordResetEmail(
        email: emailTextEditingController.text.trim()
    ).then((value){
      Fluttertoast.showToast(msg: "We have sent you an email to recover password, please check email");
    }).onError((error, stackTrace){
      Fluttertoast.showToast(msg: "Error Occured: \n ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: darkTheme ? Colors.black12 : Colors.white,
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset("images/bgLogo.png"),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Forgot Password Screen",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(100),
                                ],
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  filled: true,
                                  fillColor:
                                  darkTheme ? Colors.grey : Colors.black12,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color:
                                    darkTheme ? Colors.black54 : Colors.grey,
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Email can\'t be empty';
                                  }
                                  if (EmailValidator.validate(text) == true) {
                                    return null;
                                  }
                                  if (text.length > 99) {
                                    return 'Email can\'t be more than 100';
                                  }
                                  if (text.length < 2) {
                                    return "Enter a valid email";
                                  }
                                },
                                onChanged: (text) {
                                  setState(() {
                                    emailTextEditingController.text = text;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: () {
                                  _submit();
                                },
                                child: Text(
                                  "Send Reset Password Link",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                    darkTheme ? Colors.black : Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: darkTheme ? Colors.grey : Colors.black54,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) => const LoginScreen()));
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

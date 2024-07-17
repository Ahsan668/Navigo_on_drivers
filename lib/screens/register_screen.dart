
import 'package:firebase_database/firebase_database.dart';
import 'package:navigo_on_drivers/screens/car_info_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:navigo_on_drivers/screens/forgot_password_screen.dart';
import 'package:navigo_on_drivers/screens/login_screen.dart';

import '../global/global.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();

  bool _passwordVisible = false;

  //declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    // validate all the form fields
    if(_formKey.currentState!.validate()) {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim()
      ).then((auth) async {
        currentUser = auth.user;

        if(currentUser != null){
          Map<String, dynamic> userMap = {
            "id": currentUser!.uid,
            "name": nameTextEditingController.text.trim(),
            "email": emailTextEditingController.text.trim(),
            "address": addressTextEditingController.text.trim(),
            "phone": phoneTextEditingController.text.trim(),
          };

          DatabaseReference userRef = FirebaseDatabase.instance.ref().child("drivers");
          userRef.child(currentUser!.uid).set(userMap);

        }
        await Fluttertoast.showToast(msg: "Successfully Registered");
        Navigator.push(context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
      }).catchError((errorMessage) {
        Fluttertoast.showToast(msg: "Error occurred: \n $errorMessage");
        print("Error Occured----$errorMessage");
      });
    }
    else{
      Fluttertoast.showToast(msg: "Not all field are valid");
    }
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
                SizedBox(
                  height: 20,
                ),
                Image.asset("images/bgLogo.png"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Register",
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
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor:
                                darkTheme ? Colors.grey : Colors.black12,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: darkTheme ? Colors.black54 : Colors.grey,
                                ),
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Name can\'t be empty';
                                }
                                if (text.length > 50) {
                                  return 'Name can\'t be more than 100';
                                }
                                if (text.length < 2) {
                                  return "PLease enter a valid name";
                                }
                              },
                              onChanged: (text) {
                                setState(() {
                                  nameTextEditingController.text = text;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor:
                                darkTheme ? Colors.grey : Colors.black12,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: darkTheme ? Colors.black54 : Colors.grey,
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
                            SizedBox(
                              height: 20,
                            ),
                            IntlPhoneField(
                              showCountryFlag: true,
                              dropdownIcon: Icon(
                                Icons.arrow_drop_down,
                                color: darkTheme ? Colors.black54 : Colors.grey,
                              ),
                              decoration: InputDecoration(
                                hintText: "Phone",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor:
                                darkTheme ? Colors.grey : Colors.black12,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                              initialCountryCode: 'PK',
                              onChanged: (Text) {
                                setState(() {
                                  phoneTextEditingController.text =
                                      Text.completeNumber;
                                });
                              },
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100)
                              ],
                              decoration: InputDecoration(
                                hintText: "Address",
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor:
                                darkTheme ? Colors.grey : Colors.black12,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: darkTheme ? Colors.black54 : Colors.grey,
                                ),
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Address can\'t be empty';
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid address";
                                }
                                if (text.length > 99) {
                                  return "Address can\'t be more than 100";
                                }
                              },
                              onChanged: (text) => setState(() {
                                addressTextEditingController.text = text;
                              }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              obscureText: _passwordVisible ? true : false,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  filled: true,
                                  fillColor:
                                  darkTheme ? Colors.grey : Colors.black12,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color:
                                    darkTheme ? Colors.black54 : Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: darkTheme
                                          ? Colors.black54
                                          : Colors.grey,
                                    ),
                                  )),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password can\'t be empty';
                                }
                                if (EmailValidator.validate(text) == true) {
                                  return null;
                                }
                                if (text.length > 49) {
                                  return 'Password can\'t be more than 50';
                                }
                                if (text.length < 6) {
                                  return "Enter a valid password";
                                }
                              },
                              onChanged: (text) {
                                setState(() {
                                  confirmTextEditingController.text = text;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                              ],
                              obscureText: _passwordVisible ? true : false,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  filled: true,
                                  fillColor:
                                  darkTheme ? Colors.grey : Colors.black12,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color:
                                    darkTheme ? Colors.black54 : Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: darkTheme
                                          ? Colors.black54
                                          : Colors.grey,
                                    ),
                                  )),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password can\'t be empty';
                                }
                                if (text != passwordTextEditingController.text) {
                                  return 'Password do not match';
                                }
                                if (text.length > 49) {
                                  return 'Password can\'t be more than 50';
                                }
                                if (text.length < 6) {
                                  return "Enter a valid password";
                                }
                              },
                              onChanged: (text) {
                                setState(() {
                                  passwordTextEditingController.text = text;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                // minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                _submit();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: darkTheme ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => ForgotPasswordScreen()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style:
                                TextStyle(color: Colors.green, fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color:
                                    darkTheme ? Colors.grey : Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => LoginScreen()));
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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


















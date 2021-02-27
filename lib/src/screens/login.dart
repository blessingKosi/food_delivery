import 'package:flutter/material.dart';
import 'package:food_delivery/src/providers/user.dart';
import 'package:food_delivery/src/screens/home.dart';
import 'package:food_delivery/src/widgets/loading.dart';

import 'package:provider/provider.dart';

import 'package:food_delivery/src/helpers/screen_navigation.dart';
import 'package:food_delivery/src/helpers/style.dart';
import 'package:food_delivery/src/screens/registration.dart';
import 'package:food_delivery/src/widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: userProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/lg.png',
                        width: 240,
                        height: 240,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: userProvider.email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: userProvider.password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            icon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (!await userProvider.signIn()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text('Login failed')));
                          return;
                        }
                        userProvider.clearControllers();
                        changeScreenReplacement(context, Home());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: red,
                          border: Border.all(
                            color: grey,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Login',
                                color: white,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeScreen(
                        context,
                        RegistrationScreen(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Register here',
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
